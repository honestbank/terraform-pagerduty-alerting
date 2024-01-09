output "id" {
  description = "The ID of the service integration."
  value       = module.service_email_integration.id
}

output "integration_id" {
  description = "This is the unique key used to route events to this integration when received via the PagerDuty Events API."
  value       = module.service_email_integration.id
}

output "service_id" {
  value = module.service.id
}

output "integration_email" {
  description = "This is the unique fully-qualified email address used for routing emails to this integration for processing."
  value       = module.service_email_integration.integration_email
}
