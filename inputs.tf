variable "pagerduty_responders_engineers_level_one" {
  type = list(object({
    name  = string
    email = string
    role  = optional(string)
  }))

  description = "List of PagerDuty L1 responders."
}

variable "pagerduty_responders_engineers_level_two" {
  type = list(object({
    name  = string
    email = string
    role  = optional(string)
  }))

  description = "List of PagerDuty L2 responders."
}

variable "pagerduty_token" {
  type        = string
  description = "PagerDuty API token."
}
