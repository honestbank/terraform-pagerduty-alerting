variable "name" {
  description = "The name of the service integration."
  type        = string
}

variable "integration_email" {
  description = "This is the unique fully-qualified email address used for routing emails to this integration for processing."
  type        = string
}

variable "email_filter" {
  type = object({
    from_email_regex = string
    subject_regex    = string
  })
  default = {
    from_email_regex = null
    subject_regex    = null
  }
  description = <<-EOT
    email_filter = {
      from_email_regex : "The regex used to match the 'from' field in the inbound email. Should be a valid regex or null"
      subject_regex : "The regex used to match the 'subject' field in the inbound email. Should be a valid regex or null"
    }
  EOT
}

variable "pagerduty_token" {
  type        = string
  description = "PagerDuty API token."
}
