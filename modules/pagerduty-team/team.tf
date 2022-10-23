resource "pagerduty_team" "team" {
  name        = var.name
  description = var.description
}
