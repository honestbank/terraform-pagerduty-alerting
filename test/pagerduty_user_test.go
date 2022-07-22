package test

import (
	"github.com/gruntwork-io/terratest/modules/files"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
	"log"
	"os"
	"testing"
)

func TestPagerdutyUser(t *testing.T) {

	//runId := strings.ToLower(random.UniqueId())
	pagerdutyApiBaseUrl := "https://api.pagerduty.com"
	pagerdutyApiToken := os.Getenv("PAGERDUTY_TOKEN")

	// Working dirs
	userWorkingDir := ""
	createdUserId := ""

	if len(pagerdutyApiToken) == 0 {
		log.Println("Empty PAGERDUTY_TOKEN from env")
		t.FailNow()
	}

	test_structure.RunTestStage(t, "create_user", func() {
		userWorkingDir, createdUserId = createUser(t, "test-jai", "test-jai@honestbank.com", pagerdutyApiToken)
	})

	defer test_structure.RunTestStage(t, "destroy_user", func() {
		destroyUser(t, pagerdutyApiToken, userWorkingDir)
	})

	test_structure.RunTestStage(t, "verify_user", func() {
		verifyUser(t, createdUserId, pagerdutyApiBaseUrl, pagerdutyApiToken)
	})
}

func createUser(t *testing.T, name string, email string, pagerdutyApiToken string) (string, string) {
	workingDir := test_structure.CopyTerraformFolderToTemp(t, "..", "modules/pagerduty-user")
	log.Println("createUser - workingDir is: ", workingDir)

	testDir, _ := os.Getwd()
	pagerdutyProviderFileName := "pagerduty_provider.tf"
	pagerdutyProviderFilePath := testDir + "/" + pagerdutyProviderFileName
	copyErr := files.CopyFile(pagerdutyProviderFilePath, workingDir+"/"+pagerdutyProviderFileName)
	if copyErr != nil {
		log.Println("❌❌❌ error copying pagerduty_provider.tf: ", copyErr)
	} else {
		log.Println("✅✅✅ successfully copied pagerduty_provider.tf to: ", workingDir)
	}

	log.Println("test working dir is ", testDir)

	createUserTerraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../modules/pagerduty-user",

		Vars: map[string]interface{}{
			"name":            name,
			"email_address":   email,
			"pagerduty_token": pagerdutyApiToken,
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

func verifyUser(t *testing.T, pagerdutyUserId string, pagerdutyApiBaseUrl string, pagerdutyApiToken string) {
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
	assert.Equal(t, 200, status)
}
