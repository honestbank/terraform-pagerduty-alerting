module "user" {
  source = "../../modules/pagerduty-user"

  name          = var.name
  email_address = var.email_address
  role          = var.role
}
