output "html_url" {
  description = "URL at which the entity is uniquely displayed in the PagerDuty web UI."
  value       = pagerduty_team.team.id
}

output "id" {
  description = "The ID of the team."
  value       = pagerduty_team.team.id
}
