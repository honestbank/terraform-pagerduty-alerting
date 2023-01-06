variable "description" {
  description = "A description of the schedule."
  type        = string
}

variable "name" {
  description = "The name to set for the schedule and the base layer."
  type        = string
}

variable "rotation_turn_length_seconds" {
  description = "The time in seconds each individual is on-call for."
  type        = number
}

variable "start_datetime" {
  description = "The start date and time of the schedule/rotation - format is `2022-03-23T17:00:00+07:00`."
  type        = string
}

variable "time_zone" {
  description = "The time zone to set for the schedule (eg. `Asia/Bangkok`)."
  type        = string
}

variable "user_ids" {
  description = "An ordered list of PagerDuty User IDs to add to the schedule. The individual's order in the schedule depends on the order of this list."
  type        = list(string)
}

variable "team_ids" {
  description = "(Optional) Pagerduty Teams associated with the schedule."
  type        = list(string)
  nullable    = false
  default     = []
}
