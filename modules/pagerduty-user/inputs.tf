variable "email_address" {
  description = "The email address of the user."
  type        = string
}

variable "name" {
  description = "The name to set for the user."
  type        = string
}

variable "role" {
  default     = "user"
  description = "The user's role in PagerDuty. Can be `admin`, `limited_user`, or `user`."
  type        = string
  validation {
    condition = anytrue([
      var.role == "admin",
      var.role == "limited_user",
      var.role == "user",
    ])
    error_message = "role must be one of `admin`, `limited_user`, or `user`."
  }
}
