resource "pagerduty_service_integration" "generic_email_inbound_integration" {
  name              = var.name
  service           = var.service_id
  integration_email = var.integration_email
  # hardcoded now since we don't support multiple email filters.
  email_filter_mode = "and-rules-email"
  # hardcoded because this is a generic_email_inbound_integration module.
  type                    = "generic_email_inbound_integration"
  email_incident_creation = var.email_incident_creation
  email_filter {
    # v1 we don't expose this yet.
    body_mode = "always"

    from_email_mode  = var.email_filter.from_email_regex == null ? "always" : "match"
    from_email_regex = var.email_filter.from_email_regex

    subject_mode  = var.email_filter.subject_regex == null ? "always" : "match"
    subject_regex = var.email_filter.subject_regex
  }
}
