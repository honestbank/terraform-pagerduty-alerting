resource "pagerduty_service_integration" "generic_email_inbound_integration" {
  name              = var.name
  service           = var.service_id
  integration_email = var.integration_email
  # In the initial implementation of this module, we hardcode this value because
  # we expose configuration for only 1 email-filter object,
  # Further Enhancement: Expose this as a variable when we start exposing email filters
  # as a collection of "email_filter" objects.
  email_filter_mode = "and-rules-email"
  # This module will only encapsulate integrations of the type `generic_email_inbound_integration`
  type                    = "generic_email_inbound_integration"
  email_incident_creation = var.email_incident_creation

  email_filter {
    # We chose not to expose the body filter functionality in the initial implementation of this module, and instead hardcode
    # the best fit default here.
    # Further enhancement: Expose this attribute as a variable.
    body_mode = "always"

    from_email_mode  = var.email_filter.from_email_regex == null ? "always" : "match"
    from_email_regex = var.email_filter.from_email_regex

    subject_mode  = var.email_filter.subject_regex == null ? "always" : "match"
    subject_regex = var.email_filter.subject_regex
  }
}
