package test

import (
	"context"
	"log"
	"testing"
	"time"

	"github.com/PagerDuty/go-pagerduty"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

func TestPagerdutyEscalationPolicy(t *testing.T) {
	// Sleeping to let user licenses from previous tests be returned into the pool
	time.Sleep(10 * time.Second)

	workingDir := test_structure.CopyTerraformFolderToTemp(t, "..", "examples/pagerduty-escalation-policy")
	workingDir = "../examples/pagerduty-escalation-policy"
	defer test_structure.RunTestStage(t, "destroy_escalation_policy", func() {
		destroyEscalationPolicy(t, workingDir)
	})

	log.Println("working dir for this test is: ", workingDir)

	escalationPolicyId := ""
	runID := generateRunId()
	test_structure.RunTestStage(t, "create_escalation_policy", func() {
		escalationPolicyId = createEscalationPolicy(t, workingDir, runID)
		log.Println("created escalation policy ID: ", escalationPolicyId)
	})

	test_structure.RunTestStage(t, "verify_escalation_policy", func() {
		verifyEscalationPolicy(t, escalationPolicyId)
	})
}

func createEscalationPolicy(t *testing.T, workingDir string, runID string) string {
	escalationPolicyId := ""

	options := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: workingDir,
		Vars: map[string]interface{}{
			"schedule_suffix": runID,
		},
	})
	test_structure.SaveTerraformOptions(t, workingDir, options)
	terraform.InitAndApply(t, options)
	escalationPolicyId = terraform.Output(t, options, "id")

	return escalationPolicyId
}

func destroyEscalationPolicy(t *testing.T, workingDir string) {
	_, err := terraform.DestroyE(t, test_structure.LoadTerraformOptions(t, workingDir))
	// have to re-do destroy sometimes coz of race conditions (i.e. try to delete team while it still has associations)
	// In the retry the team will get deleted properly because the associations have been deleted in previous run
	if err != nil {
		terraform.Destroy(t, test_structure.LoadTerraformOptions(t, workingDir))
	}
}

func verifyEscalationPolicy(t *testing.T, escalationPolicyId string) {
	client := pagerduty.NewClient(loadPagerdutyToken(t))

	escalationPolicyOptions := pagerduty.GetEscalationPolicyOptions{}
	escalationPolicy, escalationPolicyErr := client.GetEscalationPolicyWithContext(context.Background(), escalationPolicyId, &escalationPolicyOptions)
	if escalationPolicyErr != nil {
		log.Println("error getting escalation policy: ", escalationPolicyErr)
	}
	log.Println("escalation policy struct: ", escalationPolicy)

	// Expected outcome/values can be seen in the screenshot in the [example's readme](../examples/pagerduty-escalation-policy/README.md)
	assert.Equal(t, 3, len(escalationPolicy.EscalationRules))
	assert.Equal(t, 1, len(escalationPolicy.EscalationRules[0].Targets))
	assert.Equal(t, 2, len(escalationPolicy.EscalationRules[1].Targets))
	assert.Equal(t, 2, len(escalationPolicy.EscalationRules[2].Targets))
	assert.Lenf(t, escalationPolicy.Teams, 1, "Expect one team is associated with this escalation policy.")
}
