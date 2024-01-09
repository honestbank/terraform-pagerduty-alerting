output "id" {
  description = "The ID of the service integration."
  value       = pagerduty_service_integration.generic_email_inbound_integration.id
}

output "integration_email" {
  description = "This is the unique fully-qualified email address used for routing emails to this integration for processing."
  value       = pagerduty_service_integration.generic_email_inbound_integration.integration_email
}
