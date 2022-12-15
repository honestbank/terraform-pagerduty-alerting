module "mock_team" {
  source = "../../modules/pagerduty-team"

  name        = "team - ${var.name}"
  description = "Created by terratest"
}


module "pagerduty_business_service" {
  source = "../../modules/pagerduty-business-service"

  name             = var.name
  description      = var.description
  point_of_contact = var.point_of_contact
  owner_team_id    = module.mock_team.id
}
