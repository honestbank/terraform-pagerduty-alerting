package test

import (
	"context"
	"github.com/PagerDuty/go-pagerduty"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"log"
	"testing"
)

func TestPagerdutyService(t *testing.T) {
	workingDir := test_structure.CopyTerraformFolderToTemp(t, "..", "examples/pagerduty-service")

	// Temporary override for local development and testing
	workingDir = "../examples/pagerduty-service"

	serviceId := ""
	test_structure.RunTestStage(t, "create_service", func() {
		serviceId = createPagerdutyService(t, workingDir)
	})
	defer test_structure.RunTestStage(t, "destroy_service", func() {
		destroyPagerdutyService(t, workingDir)
	})

	test_structure.RunTestStage(t, "verify_service", func() {
		verifyPagerdutyService(t, serviceId)
	})
}

func createPagerdutyService(t *testing.T, workingDir string) string {
	options := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: workingDir,
	})
	test_structure.SaveTerraformOptions(t, workingDir, options)
	terraform.InitAndApply(t, options)
	return terraform.Output(t, options, "service_id")
}

func destroyPagerdutyService(t *testing.T, workingDir string) {
	terraform.Destroy(t, test_structure.LoadTerraformOptions(t, workingDir))
}

func verifyPagerdutyService(t *testing.T, serviceId string) {
	client := pagerduty.NewClient(loadPagerdutyToken(t))
	options := pagerduty.GetServiceOptions{}
	service, serviceErr := client.GetServiceWithContext(context.Background(), serviceId, &options)
	if serviceErr != nil {
		log.Println("error getting service: ", serviceErr)
	}

	verifyEscalationPolicy(t, service.EscalationPolicy.ID)
}