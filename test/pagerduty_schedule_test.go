package test

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"testing"

	"github.com/PagerDuty/go-pagerduty"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

const scheduleExampleDir = "./examples/pagerduty-schedule"

func TestPagerdutySchedule(t *testing.T) {
	runID := generateRunId()
	scheduleName := fmt.Sprintf("terratest-%s", runID)
	scheduleWorkingDir := test_structure.CopyTerraformFolderToTemp(t, "..", scheduleExampleDir)
	createdScheduleId := ""
	userOneId := ""
	userTwoId := ""

	test_structure.RunTestStage(t, "create_schedule", func() {
		createdScheduleId, userOneId, userTwoId = createSchedule(t, scheduleWorkingDir, scheduleName)
		assert.NotNilf(t, createdScheduleId, "created schedule ID cannot be nil")
	})

	defer test_structure.RunTestStage(t, "destroy_schedule", func() {
		destroySchedule(t, scheduleWorkingDir)
	})

	test_structure.RunTestStage(t, "verify_schedule", func() {
		log.Println("🔎🔎🔎 About to verify schedule ID: ", createdScheduleId)
		verifySchedule(t, createdScheduleId, userOneId, userTwoId, scheduleName)
	})
}

func createSchedule(t *testing.T, workingDir string, scheduleName string) (string, string, string) {
	log.Println("about to create schedule - working dir is: ", workingDir)
	createScheduleTerraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: workingDir,
		Vars: map[string]interface{}{
			"name": scheduleName,
		},
	})
	test_structure.SaveTerraformOptions(t, workingDir, createScheduleTerraformOptions)
	terraform.InitAndApply(t, createScheduleTerraformOptions)
	createdScheduleId := terraform.Output(t, createScheduleTerraformOptions, "schedule_id")
	userOneId := terraform.Output(t, createScheduleTerraformOptions, "user_one_id")
	userTwoId := terraform.Output(t, createScheduleTerraformOptions, "user_two_id")

	log.Println("✅ 🔢 Successfully created a PagerDuty Schedule with ID: ", createdScheduleId)

	return createdScheduleId, userOneId, userTwoId
}

func destroySchedule(t *testing.T, workingDir string) {
	options := test_structure.LoadTerraformOptions(t, workingDir)
	terraform.Destroy(t, options)
}

func verifySchedule(t *testing.T, scheduleId string, userOneId string, userTwoId string, expectedScheduleName string) {
	options := createPagerdutyApiOptions(t, "GET", "/schedules/"+scheduleId)
	status, response, httpError := http_helper.HTTPDoWithOptionsE(t, options)
	log.Println("Returned error: ", httpError)
	log.Println("Returned status: ", status)
	log.Println("Returned response: ", response)

	scheduleApiResponse := pagerdutyScheduleResponse{}
	json.Unmarshal([]byte(response), &scheduleApiResponse)
	log.Println("unmarshaled response: ", scheduleApiResponse)
	log.Println("unmarshaled schedule layer: ", scheduleApiResponse.Schedule.ScheduleLayers)

	client := pagerduty.NewClient(loadPagerdutyToken(t))
	scheduleOptions := pagerduty.GetScheduleOptions{}
	schedule, getScheduleErr := client.GetScheduleWithContext(context.Background(), scheduleId, scheduleOptions)

	if getScheduleErr != nil {
		log.Println("Error getting schedule using PagerDuty SDK: ", getScheduleErr)
	}
	log.Println("Retrieved schedule from PagerDuty SDK: ", schedule)

	assert.Equal(t, expectedScheduleName, schedule.Name)
	assert.Equal(t, "Asia/Bangkok",schedule.TimeZone)

	assert.Equalf(t, 1, len(schedule.ScheduleLayers), "there must be one schedule layer created")
	assert.Equalf(t, userOneId, schedule.ScheduleLayers[0].Users[0].User.ID, "incorrect first user in schedule rotation")
	assert.Equalf(t, userTwoId, schedule.ScheduleLayers[0].Users[1].User.ID, "incorrect second user in schedule rotation")
}
