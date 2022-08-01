resource "pagerduty_service" "service" {
  name        = var.name
  description = var.description

  escalation_policy = var.escalation_policy_id

  # Set to "null" to disable
  auto_resolve_timeout = "null"

  # Time in seconds that an incident changes to the Triggered State after being Acknowledged.
  # Disabled if set to the "null" string. If not passed in, will default to '"1800"'.
  acknowledgement_timeout = (var.acknowledgement_timeout > 0 ? var.acknowledgement_timeout : "null")

  # Must be one of two values. PagerDuty receives events from your monitoring systems and can then create incidents in
  # different ways. Value "create_incidents" is default: events will create an incident that cannot be merged.
  # Value "create_alerts_and_incidents" is the alternative: events will create an alert and then add it to a new incident,
  # these incidents can be merged. This option is recommended.
  alert_creation = "create_alerts_and_incidents"

  incident_urgency_rule {
    type    = "constant"
    urgency = var.incident_urgency_rule_constant_urgency_value
  }
}
