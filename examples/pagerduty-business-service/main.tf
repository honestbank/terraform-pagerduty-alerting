resource "random_id" "random_suffix" {
  byte_length = 10
}

locals {
  random_string = random_id.random_suffix.b64_url
}

module "mock_team" {
  source = "../../modules/pagerduty-team"

  name        = "team - ${var.name} - ${local.random_string}"
  description = "Created by terratest"
}


module "pagerduty_business_service" {
  source = "../../modules/pagerduty-business-service"

  name             = "${var.name}-${local.random_string}"
  description      = var.description
  point_of_contact = var.point_of_contact
  owner_team_id    = module.mock_team.id
}
