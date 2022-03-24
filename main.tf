terraform {
  required_providers {
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = ">= 2.2"
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

resource "pagerduty_service_event_rule" "qa_priority_hours_rule" {
  service = pagerduty_service.honest_card_apis_qa.id
}
