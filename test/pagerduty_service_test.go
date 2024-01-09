package test

import (
	"context"
	"github.com/stretchr/testify/assert"
	"log"
	"testing"

	"github.com/PagerDuty/go-pagerduty"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestPagerdutyService(t *testing.T) {
	workingDir := test_structure.CopyTerraformFolderToTemp(t, "..", "examples/pagerduty-service")

	// Temporary override for local development and testing
	workingDir = "../examples/pagerduty-service"

	serviceId := ""
	serviceName := ""
	runID := generateRunId()
	test_structure.RunTestStage(t, "create_service", func() {
		serviceId, serviceName = createPagerdutyService(t, workingDir, runID)
	})
	defer test_structure.RunTestStage(t, "destroy_service", func() {
		destroyPagerdutyService(t, workingDir)
	})

	test_structure.RunTestStage(t, "verify_service", func() {
		verifyPagerdutyService(t, serviceId, serviceName)
	})
}

func createPagerdutyService(t *testing.T, workingDir string, runID string) (string, string) {
	options := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: workingDir,
		Vars: map[string]interface{}{
			"schedule_suffix": runID,
		},
	})
	test_structure.SaveTerraformOptions(t, workingDir, options)
	terraform.InitAndApply(t, options)
	return terraform.Output(t, options, "service_id"), terraform.Output(t, options, "service_name")
}

func destroyPagerdutyService(t *testing.T, workingDir string) {
	_, err := terraform.DestroyE(t, test_structure.LoadTerraformOptions(t, workingDir))
	// have to re-do destroy sometimes coz of race conditions (i.e. try to delete team while it still has associations)
	// In the retry the team will get deleted properly because the associations have been deleted in previous run
	if err != nil {
		terraform.Destroy(t, test_structure.LoadTerraformOptions(t, workingDir))
	}
}

func verifyPagerdutyService(t *testing.T, serviceId string, serviceName string) {
	client := pagerduty.NewClient(loadPagerdutyToken(t))
	options := pagerduty.GetServiceOptions{}
	service, serviceErr := client.GetServiceWithContext(context.Background(), serviceId, &options)
	if serviceErr != nil {
		log.Println("error getting service: ", serviceErr)
	}
	assert.Equal(t, serviceName, service.Name)

	verifyEscalationPolicy(t, service.EscalationPolicy.ID)
}
