resource "random_id" "random_suffix" {
  byte_length = 10
}

locals {
  random_string = random_id.random_suffix.b64_url
}

module "team" {
  source      = "../../modules/pagerduty-team"
  name        = "${var.name}-${local.random_string}"
  description = var.description

  responder_user_ids = toset([for user_id, role in var.team_members : user_id if role == "responder"])
  manager_user_ids   = toset([for user_id, role in var.team_members : user_id if role == "manager"])
  observer_user_ids  = toset([for user_id, role in var.team_members : user_id if role == "observer"])
}
