variable "pagerduty_token" {
  type        = string
  description = "PagerDuty API token."
}

provider "pagerduty" {
  token = var.pagerduty_token
}
