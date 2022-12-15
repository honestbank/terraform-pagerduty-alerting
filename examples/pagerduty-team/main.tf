module "team" {
  source      = "../../modules/pagerduty-team"
  name        = var.name
  description = var.description

  responder_user_ids = toset([for user_id, role in var.team_members : user_id if role == "responder"])
  manager_user_ids   = toset([for user_id, role in var.team_members : user_id if role == "manager"])
  observer_user_ids  = toset([for user_id, role in var.team_members : user_id if role == "observer"])
}
