variable "name" {
  default     = "example escalation policy name"
  description = "The name to set for the schedule."
  type        = string
}

variable "description" {
  default     = "example escalation policy description"
  description = "The description to set for the schedule."
  type        = string
}

variable "pagerduty_token" {
  type        = string
  description = "PagerDuty API token."
}
