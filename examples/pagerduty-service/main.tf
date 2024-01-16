resource "random_id" "random_suffix" {
  byte_length = 4
}

module "escalation_policy" {
  source = "../pagerduty-escalation-policy"

  schedule_suffix = var.schedule_suffix
  pagerduty_token = var.pagerduty_token
}

module "service" {
  source      = "../../modules/pagerduty-service"
  name        = "${var.name}-${random_id.random_suffix.b64_url}"
  description = var.description

  acknowledgement_timeout                      = 0
  escalation_policy_id                         = module.escalation_policy.id
  incident_urgency_rule_constant_urgency_value = "high"
}
