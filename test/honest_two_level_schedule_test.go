package test

import (
	"context"
	"github.com/PagerDuty/go-pagerduty"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
	"log"
	"testing"
	"time"
)

func TestHonestTwoLevelSchedule(t *testing.T) {
	workingDir := test_structure.CopyTerraformFolderToTemp(t, "..", "examples/honest-two-level-schedule")

	levelOneScheduleId := ""
	levelTwoScheduleId := ""

	log.Println("working dir for this test is: ", workingDir)

	test_structure.RunTestStage(t, "create_two_level_schedule", func() {
		levelOneScheduleId, levelTwoScheduleId = createTwoLevelScheduleWithUserCount(t, workingDir, 5)
	})

	defer test_structure.RunTestStage(t, "destroy_two_level_schedule", func() {
		destroyTwoLevelSchedule(t, workingDir)
	})

	test_structure.RunTestStage(t, "verify_two_level_schedule", func() {
		verifyTwoLevelScheduleWithUserCount(t, levelOneScheduleId, levelTwoScheduleId, 5)
	})
}

func createTwoLevelSchedule(t *testing.T, workingDir string) (string, string) {
	levelOneScheduleId := ""
	levelTwoScheduleId := ""

	options := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: workingDir,
	})
	test_structure.SaveTerraformOptions(t, workingDir, options)
	terraform.InitAndApply(t, options)
	levelOneScheduleId = terraform.Output(t, options, "level_one_schedule_id")
	levelTwoScheduleId = terraform.Output(t, options, "level_two_schedule_id")
	return levelOneScheduleId, levelTwoScheduleId
}

func createTwoLevelScheduleWithUserCount(t *testing.T, workingDir string, userCount int) (string, string) {
	levelOneScheduleId := ""
	levelTwoScheduleId := ""

	options := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: workingDir,
		Vars: map[string]interface{}{
			"dummy_user_count": userCount,
		},
	})
	test_structure.SaveTerraformOptions(t, workingDir, options)
	terraform.InitAndApply(t, options)
	levelOneScheduleId = terraform.Output(t, options, "level_one_schedule_id")
	levelTwoScheduleId = terraform.Output(t, options, "level_two_schedule_id")
	return levelOneScheduleId, levelTwoScheduleId
}

func destroyTwoLevelSchedule(t *testing.T, workingDir string) {
	terraform.Destroy(t, test_structure.LoadTerraformOptions(t, workingDir))
}

func verifyTwoLevelScheduleWithUserCount(t *testing.T, levelOneScheduleId string, levelTwoScheduleId string, userCount int) {
	client := pagerduty.NewClient(loadPagerdutyToken(t))

	onCallOptions := pagerduty.ListOnCallUsersOptions{}

	// We check one - 'now' - for the base-case without looping. We set the time interval to 1sec to ensure that we
	// only get one on-call responder for each schedule.
	since := time.Now()
	until := since.Add(1 * time.Second)

	onCallOptions.Since = since.Format(time.RFC3339)
	onCallOptions.Until = until.Format(time.RFC3339)

	log.Println("⏰⏰⏰ checking for on-call since: ", onCallOptions.Since, "// until: ", onCallOptions.Until)

	// Check on-call 'now' - this works for userCount == 2
	levelOneOnCall, listLevelOneOnCallErr := client.ListOnCallUsersWithContext(context.Background(), levelOneScheduleId, onCallOptions)
	levelTwoOnCall, listLevelTwoOnCallErr := client.ListOnCallUsersWithContext(context.Background(), levelTwoScheduleId, onCallOptions)

	if listLevelOneOnCallErr != nil {
		log.Println("error getting level one on call: ", listLevelOneOnCallErr)
	}

	if listLevelTwoOnCallErr != nil {
		log.Println("error getting level two on call: ", listLevelTwoOnCallErr)
	}

	assert.Equal(t, 1, len(levelOneOnCall))
	assert.Equal(t, 1, len(levelTwoOnCall))

	// Prevent a panic
	if len(levelOneOnCall) != 1 || len(levelTwoOnCall) != 1 {
		t.FailNow()
	}

	log.Println("1️⃣ level 1 on-call is: ", levelOneOnCall[0].ID, " || 2️⃣ level 2 on-call is: ", levelTwoOnCall[0].ID)
	assert.NotEqual(t, levelOneOnCall[0].ID, levelTwoOnCall[0].ID)

	// Check future rotations to ensure that for at least the next 2*userCount rotations no responder has overlapping
	// L1 and L2 rotations.
	for i := 1; i <= 2*userCount; i++ {
		log.Println("checking future schedule, iteration #", i)
		since = since.Add(24 * time.Hour)
		until = since.Add(1 * time.Second)

		onCallOptions.Since = since.Format(time.RFC3339)
		onCallOptions.Until = until.Format(time.RFC3339)

		log.Println("➡️ future check, iteration #", i, " - checking for on-call since: ", onCallOptions.Since, "// until: ", onCallOptions.Until)

		levelOneOnCall, listLevelOneOnCallErr = client.ListOnCallUsersWithContext(context.Background(), levelOneScheduleId, onCallOptions)
		levelTwoOnCall, listLevelTwoOnCallErr = client.ListOnCallUsersWithContext(context.Background(), levelTwoScheduleId, onCallOptions)

		if listLevelOneOnCallErr != nil {
			log.Println("error getting level one on call: ", listLevelOneOnCallErr)
		}

		if listLevelTwoOnCallErr != nil {
			log.Println("error getting level two on call: ", listLevelTwoOnCallErr)
		}

		assert.Equal(t, 1, len(levelOneOnCall))
		assert.Equal(t, 1, len(levelTwoOnCall))

		// Prevent a panic
		if len(levelOneOnCall) != 1 || len(levelTwoOnCall) != 1 {
			t.FailNow()
		}

		log.Println("1️⃣ level 1 on-call is: ", levelOneOnCall[0].ID, " || 2️⃣ level 2 on-call is: ", levelTwoOnCall[0].ID)
		assert.NotEqual(t, levelOneOnCall[0].ID, levelTwoOnCall[0].ID)

		// TODO: Check that the same user isn't scheduled consecutively (not sure if this is an issue though). The test is
		// 		 already complicated enough.
	}
}
