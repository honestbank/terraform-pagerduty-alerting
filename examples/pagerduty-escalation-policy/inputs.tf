variable "name" {
  default     = "example escalation policy name"
  description = "The name to set for the schedule."
  type        = string
}

variable "schedule_suffix" {
  description = "Suffix to the schedule names"
  type        = string
}

variable "description" {
  default     = "example escalation policy description"
  description = "The description to set for the schedule."
  type        = string
}

variable "escalation_delay_in_minutes" {
  description = "Minutes until an incident is escalated."
  default     = 60
}

variable "escalation_levels" {
  default     = []
  description = "Escalation levels and targets"
}

variable "pagerduty_token" {
  type        = string
  description = "PagerDuty API token."
  sensitive   = true
}
