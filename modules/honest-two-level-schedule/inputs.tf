variable "description" {
  description = "A description of the schedule."
  type        = string
}

variable "name" {
  description = "The name to set for the schedules and the schedule layers."
  type        = string
}

variable "rotation_turn_length_seconds" {
  description = "The time in seconds each individual is on-call for."
  type        = number
  validation {
    condition     = var.rotation_turn_length_seconds > 0
    error_message = "Rotation turn length must be greater than 0."
  }
}

variable "start_datetime" {
  default     = "2022-03-23T17:00:00+07:00"
  description = "The start date and time of the schedule/rotation - format is `2022-03-23T17:00:00+07:00`."
  type        = string
}

variable "time_zone" {
  default     = "Asia/Bangkok"
  description = "The time zone to set for the schedule (eg. `Asia/Bangkok`)."
  type        = string
}

variable "user_ids" {
  description = "An ordered list of PagerDuty User IDs to add to the schedule. The individual's order in the schedule depends on the order of this list."
  type        = list(string)
  validation {
    # This validation does not catch repeating user IDs with different cases (uppercase/lowercase, etc)
    # So duplicate values of "A" and "a" will be allowed.
    condition = alltrue([
      length(distinct(var.user_ids)) >= 2,
      length(distinct(var.user_ids)) == length(var.user_ids),
      length(distinct([for u in var.user_ids : lower(u)])) == length(var.user_ids),
    ])
    error_message = "At least two unique responders are required to build a two-level schedule. Repeated values are not allowed."
  }
}

variable "team_ids" {
  description = "(Optional) Pagerduty Teams associated with the schedules."
  type        = list(string)
  nullable    = false
  default     = []
}
