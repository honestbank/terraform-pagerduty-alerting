variable "email_address" {
  description = "The email adddress of the user"
  type        = string
}

variable "name" {
  description = "The name to set for the user"
  type        = string
}

variable "pagerduty_token" {
  type        = string
  description = "PagerDuty API token."
}
