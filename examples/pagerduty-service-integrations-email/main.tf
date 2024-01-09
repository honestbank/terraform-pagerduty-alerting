resource "random_id" "random_suffix" {
  byte_length = 10
}

locals {
  schedule_suffix = "schedule-suffix-${random_id.random_suffix.b64_url}"
  random_string   = random_id.random_suffix.b64_url
}

module "engineering_user_one" {
  source        = "../../modules/pagerduty-user"
  name          = "user-${local.random_string}"
  email_address = "user-${local.random_string}@honestbank.com"
}

module "mock_team" {
  source      = "../../modules/pagerduty-team"
  name        = "${var.name}-${local.random_string}team"
  description = "Created by terratest"
}

module "level_one_engineering_schedule" {
  source = "../../modules/pagerduty-schedule"

  description = "level one engineering schedule"
  name        = "level one engineering schedule-${local.schedule_suffix}"

  # 604,800 seconds = 1 week (7 days)
  rotation_turn_length_seconds = 604800

  # Wednesday 5pm GMT+7 rotation handover
  start_datetime = "2022-07-27T17:00:00+07:00"
  time_zone      = "Asia/Bangkok"

  user_ids = [module.engineering_user_one.id]
}

module "escalation_policy" {
  source = "../../modules/pagerduty-escalation-policy"

  name        = "${var.name}-${local.random_string}"
  description = "example escalation policy"

  escalation_delay_in_minutes = 60

  escalation_levels = [[module.level_one_engineering_schedule.id]]

  teams_id = [
    module.mock_team.id,
  ]
}

module "service" {
  source      = "../../modules/pagerduty-service"
  name        = "example-service-${random_id.random_suffix.b64_url}"
  description = "example service"

  acknowledgement_timeout                      = 0
  escalation_policy_id                         = module.escalation_policy.id
  incident_urgency_rule_constant_urgency_value = "high"
}

module "service_email_integration" {
  source            = "../../modules/pagerduty-service-integrations-email"
  integration_email = var.integration_email
  name              = var.name
  service_id        = module.service.id
  email_filter      = var.email_filter
}
