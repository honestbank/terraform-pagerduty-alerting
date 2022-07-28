variable "acknowledgement_timeout" {
  default     = 0
  description = "Time in seconds that an incident changes to the Triggered State after being Acknowledged. Set to 0 to disable."
}

variable "description" {
  description = "A description of the service."
  type        = string
}

variable "incident_urgency_rule_constant_urgency_value" {
  default     = "high"
  description = " The urgency: low Notify responders (does not escalate), high (follows escalation rules) or severity_based Set's the urgency of the incident based on the severity set by the triggering monitoring tool."
  type        = string
}

variable "name" {
  description = "The name of the service."
  type        = string
}

variable "pagerduty_token" {
  type        = string
  description = "PagerDuty API token."
}

variable "pagerduty_user_token" {
  type        = string
  description = "PagerDuty User API token."
}
