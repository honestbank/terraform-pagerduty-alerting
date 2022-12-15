variable "name" {
  description = "The name of the business service."
  type        = string
}

variable "description" {
  description = "The description of the business service."
  type        = string
}

variable "owner_team_id" {
  description = "ID of the team that owns this business service."
  type        = string
}

variable "point_of_contact" {
  description = "A string/text description of who to contact regarding this business service."
  default     = null
  type        = string
}

variable "supporting_service_ids" {
  description = "A list of PagerDuty service IDs to set as supporting services for this business service. Note that these need to be regular PagerDuty services (non-business services). For supporting business services use the `supporting_business_service_ids` variable."
  default     = []
  type        = list(string)
}

variable "supporting_business_service_ids" {
  description = "A list of PagerDuty business service IDs to set as supporting services for this business services. Only business services are supported - to set normal PagerDuty supporting services use the `supporting_service_ids` variable."
  default     = []
  type        = list(string)
}
