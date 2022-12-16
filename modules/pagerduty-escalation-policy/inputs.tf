variable "description" {
  description = "A description of the schedule."
  type        = string
}

variable "escalation_delay_in_minutes" {
  description = "The escalation delay between each layer of the escalation policy."
}

variable "escalation_levels" {
  type        = list(list(string))
  description = "A list of a list of schedules. The outer list is mapped to escalation rules, while the inner list represents multiple targets in the same escalation level."
}

variable "name" {
  description = "The name to set for the schedules and the schedule layers."
  type        = string
}

variable "teams_id" {
  description = "(Optional) Teams associated with the policy."
  type        = list(string)
  default     = []
}
