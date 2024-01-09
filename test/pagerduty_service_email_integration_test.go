package test

import (
	"context"
	"fmt"
	"github.com/stretchr/testify/assert"
	"log"
	"testing"

	"github.com/PagerDuty/go-pagerduty"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestPagerdutyServiceEmailIntegration(t *testing.T) {
	workingDir := test_structure.CopyTerraformFolderToTemp(t, "..", "examples/pagerduty-service-integrations-email")

	// Temporary override for local development and testing
	workingDir = "../examples/pagerduty-service-integrations-email"
	serviceId := ""
	integrationId := ""
	emailFilter := EmailFilter{}
	runID := generateRunId()
	integrationEmail := fmt.Sprintf("example%s@honest-test.pagerduty.com", runID)
	integrationName := fmt.Sprintf("example-pagerduty-service-integrations-email-%s", runID)

	test_structure.RunTestStage(t, "create_service_integration_email", func() {
		serviceId, integrationId, emailFilter = createPagerdutyServiceIntegration(t, workingDir, integrationEmail, integrationName)
	})

	defer test_structure.RunTestStage(t, "destroy_service_integration_email", func() {
		destroyPagerdutyServiceEmailIntegration(t, workingDir)
	})

	test_structure.RunTestStage(t, "verify_service_email_integration", func() {
		verifyPagerdutyServiceEmailIntegration(t, serviceId, integrationId, integrationName, integrationEmail, emailFilter)
	})
}

func createPagerdutyServiceIntegration(t *testing.T, workingDir string, integrationEmail string, integrationName string) (string, string, EmailFilter) {
	subjectRegex := "(CRITICAL*)"
	fromEmailRegex := "(@foo.test*)"
	options := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: workingDir,
		Vars: map[string]interface{}{
			"name":              integrationName,
			"integration_email": integrationEmail,
			"email_filter": map[string]interface{}{
				"subject_mode":     "match",
				"subject_regex":    subjectRegex,
				"body_mode":        "always",
				"body_regex":       nil,
				"from_email_mode":  "match",
				"from_email_regex": fromEmailRegex,
			},
		},
	})
	test_structure.SaveTerraformOptions(t, workingDir, options)
	terraform.InitAndApply(t, options)
	return terraform.Output(t, options, "service_id"), terraform.Output(t, options, "integration_id"), EmailFilter{
		SubjectMode:    pagerduty.EmailFilterRuleModeMatch,
		SubjectRegex:   subjectRegex,
		BodyMode:       pagerduty.EmailFilterRuleModeAlways,
		FromEmailMode:  pagerduty.EmailFilterRuleModeMatch,
		FromEmailRegex: fromEmailRegex,
	}
}

type EmailFilter struct {
	SubjectMode    pagerduty.IntegrationEmailFilterRuleMode
	SubjectRegex   string
	BodyMode       pagerduty.IntegrationEmailFilterRuleMode
	FromEmailMode  pagerduty.IntegrationEmailFilterRuleMode
	FromEmailRegex string
}

func destroyPagerdutyServiceEmailIntegration(t *testing.T, workingDir string) {
	_, err := terraform.DestroyE(t, test_structure.LoadTerraformOptions(t, workingDir))
	// have to re-do destroy sometimes coz of race conditions (i.e. try to delete team while it still has associations)
	// In the retry the team will get deleted properly because the associations have been deleted in previous run
	if err != nil {
		terraform.Destroy(t, test_structure.LoadTerraformOptions(t, workingDir))
	}
}

func verifyPagerdutyServiceEmailIntegration(
	t *testing.T,
	serviceId string,
	integrationId string,
	expectedIntegrationName string,
	expectedIntegrationEmail string,
	expectedEmailFilter EmailFilter,
) {
	client := pagerduty.NewClient(loadPagerdutyToken(t))
	options := pagerduty.GetIntegrationOptions{}
	integration, serviceErr := client.GetIntegrationWithContext(context.Background(), serviceId, integrationId, options)
	if serviceErr != nil {
		log.Println("error getting service integration: ", serviceErr)
	}
	assert.Equal(t, integrationId, integration.ID)
	assert.Equal(t, expectedIntegrationEmail, integration.IntegrationEmail)
	assert.Equal(t, serviceId, integration.Service.ID)
	emailFilter := integration.EmailFilters[0]
	realEmailFilter := EmailFilter{
		SubjectMode:    emailFilter.SubjectMode,
		SubjectRegex:   *emailFilter.SubjectRegex,
		BodyMode:       emailFilter.BodyMode,
		FromEmailMode:  emailFilter.FromEmailMode,
		FromEmailRegex: *emailFilter.FromEmailRegex,
	}
	assert.Equal(t, expectedEmailFilter, realEmailFilter)
	assert.Equal(t, expectedIntegrationName, integration.Name)
}