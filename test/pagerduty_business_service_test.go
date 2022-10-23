package test

import (
	"context"
	"fmt"
	"log"
	"testing"

	"github.com/PagerDuty/go-pagerduty"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)


const businessServiceExampleDir = "./examples/pagerduty-business-service"
const businessServiceDescriptionMock = "Created by Terratest"
const businessServicePointOfContactMock = "Terratest - Contact the engineers"
func TestPagerdutyBusinessService(t *testing.T) {
	workingDir := test_structure.CopyTerraformFolderToTemp(t, "..", businessServiceExampleDir)

	businessServiceID := ""
	runID := generateRunId()

	businessServiceName := fmt.Sprintf("terratest-%s", runID)
	test_structure.RunTestStage(t, "create_business_service", func() {
		businessServiceID = createPagerdutyBusinessService(t, workingDir, businessServiceName)
	})
	defer test_structure.RunTestStage(t, "destroy_business_service", func() {
		destroyPagerdutyBusinessService(t, workingDir)
	})

	test_structure.RunTestStage(t, "verify_business_service", func() {
		verifyPagerdutyBusinessService(t, businessServiceID, businessServiceName)
	})
}

func createPagerdutyBusinessService(t *testing.T, workingDir string, businessServiceName string) string {
	options := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: workingDir,
		Vars: map[string]interface{}{
			"name": businessServiceName,
			"description": businessServiceDescriptionMock,
			"point_of_contact": businessServicePointOfContactMock,
		},
	})
	test_structure.SaveTerraformOptions(t, workingDir, options)
	terraform.InitAndApply(t, options)
	return terraform.Output(t, options, "business_service_id")
}

func destroyPagerdutyBusinessService(t *testing.T, workingDir string) {
	terraform.Destroy(t, test_structure.LoadTerraformOptions(t, workingDir))
}

func verifyPagerdutyBusinessService(t *testing.T, serviceID string, expectedBussinessServiceName string) {
	client := pagerduty.NewClient(loadPagerdutyToken(t))
	businessService, serviceErr := client.GetBusinessServiceWithContext(context.Background(), serviceID)
	if serviceErr != nil {
		log.Println("error getting service: ", serviceErr)
	}

	assert.Equal(t, expectedBussinessServiceName, businessService.Name)
}
