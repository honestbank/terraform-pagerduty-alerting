module "engineering_user_one" {
  source        = "../../modules/pagerduty-user"
  name          = "pagerduty-escalation-policy-example-engineering-user-one"
  email_address = "pagerduty-escalation-policy-example-engineering-user-one@honestbank.com"
}

module "engineering_user_two" {
  source        = "../../modules/pagerduty-user"
  name          = "pagerduty-escalation-policy-example-engineering-user-two"
  email_address = "pagerduty-escalation-policy-example-engineering-user-two@honestbank.com"
}

module "engineering_lead" {
  source        = "../../modules/pagerduty-user"
  name          = "pagerduty-escalation-policy-example-engineering-lead"
  email_address = "pagerduty-escalation-policy-example-engineering-lead@honestbank.com"
}

module "product_manager" {
  source        = "../../modules/pagerduty-user"
  name          = "pagerduty-escalation-policy-example-product-manager"
  email_address = "pagerduty-escalation-policy-example-product-manager@honestbank.com"
}

module "product_lead" {
  source        = "../../modules/pagerduty-user"
  name          = "pagerduty-escalation-policy-example-product-lead"
  email_address = "pagerduty-escalation-policy-example-product-lead@honestbank.com"
}

module "honest_service" {
  source = "../../modules/honest-pagerduty-service"

  name        = var.name
  description = var.description

  responders = {
    engineers        = [module.engineering_user_one.id, module.engineering_user_two.id],
    product_manager  = module.product_manager.id,
    engineering_lead = module.engineering_lead.id,
    product_lead     = module.product_lead.id,
  }
}
