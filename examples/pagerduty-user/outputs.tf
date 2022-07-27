output "id" {
  description = "The ID of the user"
  value       = module.user.id
}

output "html_url" {
  description = "URL at which the entity is uniquely displayed in the Web app"
  value       = module.user.html_url
}

output "invitation_sent" {
  description = "If true, the user has an outstanding invitation"
  value       = module.user.invitation_sent
}
