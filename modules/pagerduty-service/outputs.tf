output "id" {
  description = "The `id` attribute of the service."
  value       = pagerduty_service.service.id
}

output "service_name" {
  value = pagerduty_service.service.name
}
