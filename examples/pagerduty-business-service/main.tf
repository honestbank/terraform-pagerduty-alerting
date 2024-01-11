resource "random_id" "random_suffix" {
  byte_length = 4
}

locals {
  random_suffix = random_id.random_suffix.b64_url
}

module "mock_team" {
  source = "../../modules/pagerduty-team"

  name        = "team - ${var.name} - ${local.random_suffix}"
  description = "Created by terratest"
}


module "pagerduty_business_service" {
  source = "../../modules/pagerduty-business-service"

  name             = "${var.name}-${local.random_suffix}"
  description      = var.description
  point_of_contact = var.point_of_contact
  owner_team_id    = module.mock_team.id
}
