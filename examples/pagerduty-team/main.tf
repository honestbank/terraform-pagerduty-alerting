module "team" {
  source      = "../../modules/pagerduty-team"
  name        = var.name
  description = var.description
}
