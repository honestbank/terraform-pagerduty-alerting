package test

import (
	"context"
	"github.com/PagerDuty/go-pagerduty"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
	"log"
	"os"
	"testing"
)

func TestPagerdutyUser(t *testing.T) {
	pagerdutyApiToken := loadPagerdutyToken(t)

	// Working dirs
	userWorkingDir := ""

	// For assignment later
	createdUserId := ""

	test_structure.RunTestStage(t, "create_user", func() {
		userWorkingDir, createdUserId = createUser(t, "user", pagerdutyApiToken)
	})

	defer test_structure.RunTestStage(t, "destroy_user", func() {
		destroyUser(t, pagerdutyApiToken, userWorkingDir)
	})

	test_structure.RunTestStage(t, "verify_user", func() {
		verifyUser(t, createdUserId, "user", pagerdutyApiBaseUrl, pagerdutyApiToken)
	})
}

func TestPagerdutyAdminUser(t *testing.T) {
	pagerdutyApiToken := loadPagerdutyToken(t)

	// Working dirs
	userWorkingDir := ""

	// For assignment later
	createdUserId := ""

	test_structure.RunTestStage(t, "create_user", func() {
		userWorkingDir, createdUserId = createUser(t, "admin", pagerdutyApiToken)
	})

	defer test_structure.RunTestStage(t, "destroy_user", func() {
		destroyUser(t, pagerdutyApiToken, userWorkingDir)
	})

	test_structure.RunTestStage(t, "verify_user", func() {
		verifyUser(t, createdUserId, "admin", pagerdutyApiBaseUrl, pagerdutyApiToken)

	})
}

func createUser(t *testing.T, role string, pagerdutyApiToken string) (string, string) {
	//workingDir := test_structure.CopyTerraformFolderToTemp(t, "..", "modules/pagerduty-user")
	workingDir := "../examples/pagerduty-user"
	log.Println("createUser - workingDir is: ", workingDir)

	testDir, _ := os.Getwd()

	log.Println("test working dir is ", testDir)

	createUserTerraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/pagerduty-user",

		Vars: map[string]interface{}{
			"pagerduty_token": pagerdutyApiToken,
			"role":            role,
		},
	})

	test_structure.SaveTerraformOptions(t, workingDir, createUserTerraformOptions)
	terraform.InitAndApply(t, createUserTerraformOptions)
	pagerdutyUserId := terraform.Output(t, createUserTerraformOptions, "id")
	log.Println("🔢 returning PagerDuty User ID: ", pagerdutyUserId)

	return workingDir, pagerdutyUserId
}

func destroyUser(t *testing.T, pagerdutyApiToken string, workingDir string) {
	terraformOptions := test_structure.LoadTerraformOptions(t, workingDir)
	terraform.Destroy(t, terraformOptions)
}

func verifyUser(t *testing.T, pagerdutyUserId string, role string, pagerdutyApiBaseUrl string, pagerdutyApiToken string) {
	pagerdutyApiOptions := http_helper.HttpDoOptions{
		Method: "GET",
		Url:    pagerdutyApiBaseUrl + "/users/" + pagerdutyUserId,
		Headers: map[string]string{
			"Authorization": "Token token=" + pagerdutyApiToken,
		},
	}

	status, response, httpError := http_helper.HTTPDoWithOptionsE(t, pagerdutyApiOptions)
	log.Println("Returned error: ", httpError)
	log.Println("Returned status: ", status)
	log.Println("Returned response: ", response)

	// Should return 200
	assert.Equalf(t, 200, status, "incorrect response code, expected 200")
	assert.Containsf(t, response, "\"name\":\"example\"", "correct name not found")
	assert.Containsf(t, response, "\"email\":\"pagerduty-user-example@honestbank.com\"", "correct email not found")

	client := pagerduty.NewClient(loadPagerdutyToken(t))
	getUserOptions := pagerduty.GetUserOptions{}
	user, userErr := client.GetUserWithContext(context.Background(), pagerdutyUserId, getUserOptions)
	if userErr != nil {
		t.Fail()
		log.Println("error getting user from PagerDuty SDK: ", userErr)
	}
	assert.Equal(t, role, user.Role)
}