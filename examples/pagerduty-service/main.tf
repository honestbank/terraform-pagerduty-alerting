module "escalation_policy" {
  source = "../pagerduty-escalation-policy"

  pagerduty_token = var.pagerduty_token
}

module "service" {
  source      = "../../modules/pagerduty-service"
  name        = var.name
  description = var.description

  acknowledgement_timeout                      = 0
  escalation_policy_id                         = module.escalation_policy.id
  incident_urgency_rule_constant_urgency_value = "high"
}
