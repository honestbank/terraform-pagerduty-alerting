locals {
  CONST_HONEST_SLACK_WORKSPACE_ID            = "TM4HHNXLM"
  CONST_HONEST_SLACK_INCIDENTS_CHANNEL_ID    = "C03A1EXJCRF"
  CONST_HONEST_PAGERDUTY_PRIORITY_NAME_SEV_1 = "Sev 1"
  CONST_HONEST_PAGERDUTY_PRIORITY_NAME_SEV_2 = "Sev 2"
}

module "engineer_schedule" {
  source = "../honest-two-level-schedule"

  name                         = "${var.name} - Engineering"
  description                  = "${var.description} - Engineering Schedule"
  rotation_turn_length_seconds = 604800
  user_ids                     = var.responders.engineers
}

module "product_manager_schedule" {
  source = "../pagerduty-schedule"

  name        = "${var.name} - Product Mangager"
  description = "${var.description} - Product Mangager Schedule"

  # Wednesday 5pm GMT+7 rotation handover
  start_datetime               = "2022-07-27T17:00:00+07:00"
  time_zone                    = "Asia/Bangkok"
  rotation_turn_length_seconds = 604800

  user_ids = [var.responders.product_manager]
}

module "engineering_lead_schedule" {
  source = "../pagerduty-schedule"

  name        = "${var.name} - Engineering Lead"
  description = "${var.description} - Engineering Lead Schedule"

  # Wednesday 5pm GMT+7 rotation handover
  start_datetime               = "2022-07-27T17:00:00+07:00"
  time_zone                    = "Asia/Bangkok"
  rotation_turn_length_seconds = 604800

  user_ids = [var.responders.engineering_lead]
}

module "product_lead_schedule" {
  source = "../pagerduty-schedule"

  name        = "${var.name} - Product Lead"
  description = "${var.description} - Product Lead Schedule"

  # Wednesday 5pm GMT+7 rotation handover
  start_datetime               = "2022-07-27T17:00:00+07:00"
  time_zone                    = "Asia/Bangkok"
  rotation_turn_length_seconds = 604800

  user_ids = [var.responders.product_lead]
}

module "escalation_policy" {
  source = "../pagerduty-escalation-policy"

  name        = "${var.name} Escalation Policy"
  description = "${var.description} Escalation Policy"

  escalation_delay_in_minutes = "60"

  escalation_levels = [
    [module.engineer_schedule.level_one_schedule_id],
    [module.engineer_schedule.level_two_schedule_id, module.product_manager_schedule.id],
    [module.engineering_lead_schedule.id, module.product_lead_schedule.id]
  ]
}

module "service" {
  source = "../pagerduty-service"

  name                                         = var.name
  description                                  = var.description
  escalation_policy_id                         = module.escalation_policy.id
  incident_urgency_rule_constant_urgency_value = var.incident_urgency_rule_constant_urgency_value
  acknowledgement_timeout                      = var.acknowledgement_timeout
}

data "pagerduty_priority" "sev1" {
  name = local.CONST_HONEST_PAGERDUTY_PRIORITY_NAME_SEV_1
}

data "pagerduty_priority" "sev2" {
  name = local.CONST_HONEST_PAGERDUTY_PRIORITY_NAME_SEV_2
}

resource "pagerduty_slack_connection" "service_slack_connection_incidents_channel" {
  source_id    = module.service.id
  source_type  = "service_reference"
  workspace_id = local.CONST_HONEST_SLACK_WORKSPACE_ID
  channel_id   = local.CONST_HONEST_SLACK_INCIDENTS_CHANNEL_ID

  notification_type = "stakeholder"
  config {
    events = [
      "incident.triggered",
      "incident.acknowledged",
      "incident.resolved",
      "incident.reassigned",
      "incident.escalated",
      "incident.annotated",
      "incident.delegated",
      "incident.priority_updated",
      "incident.responder.added",
      "incident.responder.replied",
      "incident.status_update_published",
    ]
    priorities = [
      data.pagerduty_priority.sev1.id,
      data.pagerduty_priority.sev2.id,
    ]
    urgency = "high"
  }
}
