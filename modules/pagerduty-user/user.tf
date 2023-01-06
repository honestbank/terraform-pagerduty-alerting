resource "pagerduty_user" "user" {
  name  = var.name
  email = var.email_address

  role = var.role

  lifecycle {
    ignore_changes = [
      job_title # This implies we do not manage Job title in code and will be managed through web UI.
    ]
  }
}
