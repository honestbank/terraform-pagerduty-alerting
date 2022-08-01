resource "pagerduty_escalation_policy" "escalation_policy" {
  name        = var.name
  description = var.description

  dynamic "rule" {
    for_each = var.escalation_levels
    content {
      escalation_delay_in_minutes = var.escalation_delay_in_minutes

      dynamic "target" {
        for_each = rule.value
        content {
          type = "schedule_reference"
          id   = target.value
        }
      }
    }
  }
}
