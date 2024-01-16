variable "name" {
  description = "The name of the service integration."
  type        = string
}

variable "service_id" {
  description = "The ID of the service the integration should belong to."
  type        = string
}

variable "integration_email" {
  description = "This is the unique fully-qualified email address used for routing emails to this integration for processing."
  type        = string
}

variable "email_incident_creation" {
  default     = "use_rules"
  description = "Behaviour of Email Management feature (explained in PD docs)[https://support.pagerduty.com/docs/email-management-filters-and-rules#control-when-a-new-incident-or-alert-is-triggered]. Can be on_new_email, on_new_email_subject, only_if_no_open_incidents or use_rules."

  validation {
    condition     = contains(["on_new_email", "on_new_email_subject", "only_if_no_open_incidents", "use_rules"], var.email_incident_creation)
    error_message = "Invalid value passed to email_incident_creation. Must be one of on_new_email, on_new_email_subject, only_if_no_open_incidents or use_rules."
  }
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
