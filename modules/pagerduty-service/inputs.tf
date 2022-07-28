variable "acknowledgement_timeout" {
  description = "Time in seconds that an incident changes to the Triggered State after being Acknowledged. Set to 0 to disable."
}

variable "description" {
  description = "A description of the service."
  type        = string
}

variable "escalation_policy_id" {
  description = "The escalation policy to use for this service."
  type        = string
}

variable "incident_urgency_rule_constant_urgency_value" {
  description = " The urgency: low Notify responders (does not escalate), high (follows escalation rules) or severity_based Set's the urgency of the incident based on the severity set by the triggering monitoring tool."
  type        = string
}

variable "name" {
  description = "The name of the service."
  type        = string
}
