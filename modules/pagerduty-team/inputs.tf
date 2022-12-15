variable "description" {
  description = "A description of the team. If not set, a placeholder of `Managed by Terraform` will be set."
  type        = string
}

variable "name" {
  description = "The name of the team."
  type        = string
}

variable "parent" {
  description = " (Optional) ID of the parent team. This is available to accounts with the Team Hierarchy feature enabled."
  type        = string
  default     = null
}

variable "responder_user_ids" {
  description = <<EOF
    List of Pagerduty user IDs of the responder in this team.
    Example: [userid1, userid2]
  EOF
  type        = list(string)
    default = []
}

variable "manager_user_ids" {
  description = <<EOF
    Pagerduty user IDs of the product manager of this team.
    Example: "userid1"
  EOF
  type        = list(string)
    default = []
}

variable "observer_user_ids" {
  description = <<EOF
    List of Pagerduty user IDs of the observers in this team.
    Example: [userid1, userid2]
  EOF
  type        = list(string)
  default = []
}
