output "id" {
  description = "The ID of the user."
  value       = module.stakeholder.id
}

output "html_url" {
  description = "URL at which the entity is uniquely displayed in the Web app."
  value       = module.stakeholder.html_url
}

output "invitation_sent" {
  description = "If true, the user has an outstanding invitation."
  value       = module.stakeholder.invitation_sent
}
