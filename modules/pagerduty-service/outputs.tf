output "id" {
  description = "The `id` attribute of the service."
  value       = pagerduty_service.service.id
}

output "service_name" {
  description = "The name of the service being created"
  value       = pagerduty_service.service.name
}
