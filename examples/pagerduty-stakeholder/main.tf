resource "random_id" "random_suffix" {
  byte_length = 10
}

locals {
  random_string = random_id.random_suffix.b64_url
}

module "stakeholder" {
  source = "../../modules/pagerduty-user"

  name          = "${var.name}-${local.random_string}"
  email_address = var.email_address
  role          = var.role
}
