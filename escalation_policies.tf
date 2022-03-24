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
