package test

import (
	"context"
	"log"
	"testing"

	"github.com/PagerDuty/go-pagerduty"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)


const roleManager = "manager"
const roleEngineer = "engineer"

func TestPagerdutyTeam(t *testing.T) {

	// This will verify the presence of the token as well as return it
	_ = loadPagerdutyToken(t)
	workingDir := "../examples/pagerduty-team"
	// Value will be assigned once team is created, for verification
	createdTeamId := ""
	runId := generateRunId()
	teamName := "terratest team " + runId
	teamDescription := "This team was created by Terratest from the terraform-pagerduty repo with run ID: " + runId
    teamMembers := map[string]string{}
	test_structure.RunTestStage(t, "create_team", func() {
		options := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
			TerraformDir: workingDir,
			Vars: map[string]interface{}{
				"name":        teamName,
				"description": teamDescription,
				"team_members": teamMembers,
			},
		})
		test_structure.SaveTerraformOptions(t, workingDir, options)
		terraform.InitAndApply(t, options)
		createdTeamId = terraform.Output(t, options, "id")
		log.Println("Created team ID: ", createdTeamId)
	})

	test_structure.RunTestStage(t, "verify_team", func() {
		client := pagerduty.NewClient(loadPagerdutyToken(t))
		options := pagerduty.ListTeamOptions{}
		teams, teamsErr := client.ListTeamsWithContext(context.Background(), options)
		if teamsErr != nil {
			log.Println("error listing teams", teamsErr)
		}
		log.Println("List Teams returned: ", teams.Teams)

		var targetTeam pagerduty.Team
		for _, team := range teams.Teams {
			if team.Name == teamName && team.Description == teamDescription {
				targetTeam = team
				break
			}
		}
		assert.NotNil(t, targetTeam)

	})

	test_structure.RunTestStage(t, "destroy_team", func() {
		terraform.Destroy(t, test_structure.LoadTerraformOptions(t, workingDir))
	})
}
