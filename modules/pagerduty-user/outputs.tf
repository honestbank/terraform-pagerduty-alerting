output "id" {
  description = "The ID of the user"
  value       = pagerduty_user.user.id
}

output "html_url" {
  description = "URL at which the entity is uniquely displayed in the Web app"
  value       = pagerduty_user.user.html_url
}

output "invitation_sent" {
  description = "If true, the user has an outstanding invitation"
  value       = pagerduty_user.user.invitation_sent
}
