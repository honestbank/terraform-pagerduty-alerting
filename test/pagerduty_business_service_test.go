package test

import (
	"context"
	"fmt"
	"log"
	"strings"
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
	defer test_structure.RunTestStage(t, "destroy_business_service", func() {
		destroyPagerdutyBusinessService(t, workingDir)
	})

	businessServiceID := ""
	runID := generateRunId()

	businessServiceName := fmt.Sprintf("terratest-%s", runID)
	test_structure.RunTestStage(t, "create_business_service", func() {
		businessServiceID = createPagerdutyBusinessService(t, workingDir, businessServiceName)
	})

	test_structure.RunTestStage(t, "verify_business_service", func() {
		verifyPagerdutyBusinessService(t, businessServiceID, businessServiceName)
	})
}

func createPagerdutyBusinessService(t *testing.T, workingDir string, businessServiceName string) string {
	options := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: workingDir,
		Vars: map[string]interface{}{
			"name":             businessServiceName,
			"description":      businessServiceDescriptionMock,
			"point_of_contact": businessServicePointOfContactMock,
		},
	})
	test_structure.SaveTerraformOptions(t, workingDir, options)
	terraform.InitAndApply(t, options)
	return terraform.Output(t, options, "business_service_id")
}

func destroyPagerdutyBusinessService(t *testing.T, workingDir string) {
	_, err := terraform.DestroyE(t, test_structure.LoadTerraformOptions(t, workingDir))
	// have to re-do destroy sometimes because of race conditions (i.e. try to delete team while it still has associations)
	// In the retry the team will get deleted properly because the associations have been deleted in previous run
	if err != nil {
		terraform.Destroy(t, test_structure.LoadTerraformOptions(t, workingDir))
	}
}

func verifyPagerdutyBusinessService(t *testing.T, serviceID string, expectedBussinessServiceName string) {
	client := pagerduty.NewClient(loadPagerdutyToken(t))
	businessService, serviceErr := client.GetBusinessServiceWithContext(context.Background(), serviceID)
	if serviceErr != nil {
		log.Println("error getting service: ", serviceErr)
	}
	fmt.Printf("comparing strings %s with %s", expectedBussinessServiceName, businessService.Name)
	assert.True(t, strings.HasPrefix(businessService.Name, expectedBussinessServiceName))
}
