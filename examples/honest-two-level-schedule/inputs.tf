variable "name" {
  description = "The name to set for the schedule."
  type        = string
}

variable "team_name" {
  description = "The name of the Team to set for the schedule."
  type        = string
}

variable "pagerduty_token" {
  type        = string
  description = "PagerDuty API token."
}

variable "dummy_user_count" {
  type        = number
  default     = 2
  description = "The number of dummy users to create to place into rotation."
}
