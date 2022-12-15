output "html_url" {
  description = "A URL at which the entity is uniquely displayed in the PagerDuty web UI."
  value       = pagerduty_business_service.business_service.html_url
}

output "id" {
  description = "The ID of the business service."
  value       = pagerduty_business_service.business_service.id
}

output "self" {
  description = "The API show URL at which the object is accessible."
  value       = pagerduty_business_service.business_service.self
}

output "summary" {
  description = "A short-form, server-generated string that provides succinct, important information about an object suitable for primary labeling of an entity in a client. In many cases, this will be identical to name, though it is not intended to be an identifier."
  value       = pagerduty_business_service.business_service.summary
}
