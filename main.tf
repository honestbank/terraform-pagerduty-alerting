terraform {
  required_providers {
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = "~> 2.2.1"
    }
  }

  experiments = [module_variable_optional_attrs]
}

provider "pagerduty" {
  token = var.pagerduty_token
}

resource "pagerduty_user" "devops_test_user_one" {
  email = "devops+pagerduty_test_user_one@honestbank.com"
  name  = "[Terraform] DevOps Engineers - Test User One"
}

resource "pagerduty_user" "devops_test_user_two" {
  email = "devops+pagerduty_test_user_two@honestbank.com"
  name  = "[Terraform] DevOps Engineers - Test User Two"
}

# This iterator isn't great but it's the only way
# to use a list of objects.
resource "pagerduty_user" "level_one_responders" {
  for_each = {
    for index, user_object in var.pagerduty_responders_engineers_level_one :
    user_object.email => user_object
  }

  name  = each.value.name
  email = each.value.email
  role  = try(each.value.role, "user")
}

resource "pagerduty_schedule" "engineering_level_one_schedule" {
  name      = "[Terraform] Engineering L1 Schedule"
  time_zone = "Asia/Bangkok"

  layer {
    name                         = "L1 Rotation"
    start                        = "2022-03-23T17:00:00+07:00"
    rotation_virtual_start       = "2022-03-23T17:00:00+07:00"
    rotation_turn_length_seconds = 604800
    users = [
      for key, value in pagerduty_user.level_one_responders : value.id
    ]
  }
}

# Level Two

resource "pagerduty_user" "level_two_responders" {
  for_each = {
    for index, user_object in var.pagerduty_responders_engineers_level_two :
    user_object.email => user_object
  }

  name  = each.value.name
  email = each.value.email
  role  = try(each.value.role, "user")
}

resource "pagerduty_schedule" "engineering_level_two_schedule" {
  name      = "[Terraform] Engineering L2 Schedule"
  time_zone = "Asia/Bangkok"

  layer {
    name                         = "L1 Rotation"
    start                        = "2022-03-23T17:00:00+07:00"
    rotation_virtual_start       = "2022-03-23T17:00:00+07:00"
    rotation_turn_length_seconds = 604800
    users = [
      for key, value in pagerduty_user.level_two_responders : value.id
    ]
  }
}

resource "pagerduty_escalation_policy" "engineering_escalation_policy" {
  name        = "[Terraform] Engineering Escalation Policy"
  description = "Escalation policy for Honest Engineering team."

  rule {
    escalation_delay_in_minutes = 30
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.engineering_level_one_schedule.id
    }
  }

}

resource "pagerduty_service" "honest_card_apis_qa" {
  name        = "[Terraform] [QA] Honest Card APIs"
  description = "Service triggered by downtime of the Honest Card APIs on QA."

  auto_resolve_timeout    = "null"
  acknowledgement_timeout = "null"
  escalation_policy       = pagerduty_escalation_policy.engineering_escalation_policy.id
  alert_creation          = "create_alerts_and_incidents"

  incident_urgency_rule {
    type = "use_support_hours"

    during_support_hours {
      type    = "constant"
      urgency = "high"
    }
    outside_support_hours {
      type    = "constant"
      urgency = "low"
    }
  }

  support_hours {
    type         = "fixed_time_per_day"
    time_zone    = "Asia/Jakarta"
    start_time   = "08:00:00"
    end_time     = "20:00:00"
    days_of_week = [1, 2, 3, 4, 5]
  }

  scheduled_actions {
    type       = "urgency_change"
    to_urgency = "high"

    at {
      type = "named_time"
      name = "support_hours_start"
    }
  }
}
