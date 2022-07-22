resource "pagerduty_user" "user" {
  name  = var.name
  email = var.email_address
}
