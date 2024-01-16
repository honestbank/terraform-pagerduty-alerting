resource "random_id" "random_suffix" {
  byte_length = 4
}

locals {
  random_suffix = random_id.random_suffix.b64_url
}

module "user" {
  source = "../../modules/pagerduty-user"

  name          = "${var.name}-${local.random_suffix}"
  email_address = var.email_address
  role          = var.role
}
