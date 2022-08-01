variable "name" {
  description = "The name to set for the schedule."
  type        = string
}

variable "pagerduty_token" {
  type        = string
  description = "PagerDuty API token."
}
