package test

import (
	"context"
	"github.com/PagerDuty/go-pagerduty"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
	"log"
	"testing"
)

func TestPagerdutyEscalationPolicy(t *testing.T) {
	workingDir := test_structure.CopyTerraformFolderToTemp(t, "..", "examples/pagerduty-escalation-policy")
	workingDir = "../examples/pagerduty-escalation-policy"

	log.Println("working dir for this test is: ", workingDir)

	escalationPolicyId := ""

	test_structure.RunTestStage(t, "create_escalation_policy", func() {
		escalationPolicyId = createEscalationPolicy(t, workingDir)
		log.Println("created escalation policy ID: ", escalationPolicyId)
	})

	defer test_structure.RunTestStage(t, "destroy_escalation_policy", func() {
		destroyEscalationPolicy(t, workingDir)
	})

	test_structure.RunTestStage(t, "verify_escalation_policy", func() {
		verifyEscalationPolicy(t, escalationPolicyId)
	})
}

func createEscalationPolicy(t *testing.T, workingDir string) string {
	escalationPolicyId := ""

	options := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: workingDir,
	})
	test_structure.SaveTerraformOptions(t, workingDir, options)
	terraform.InitAndApply(t, options)
	escalationPolicyId = terraform.Output(t, options, "id")

	return escalationPolicyId
}

func destroyEscalationPolicy(t *testing.T, workingDir string) {
	terraform.Destroy(t, test_structure.LoadTerraformOptions(t, workingDir))
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
}