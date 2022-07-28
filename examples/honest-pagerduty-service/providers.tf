terraform {
  required_providers {
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = ">= 2.2"
    }
  }

  experiments = [module_variable_optional_attrs]
}

provider "pagerduty" {
  token      = var.pagerduty_token
  user_token = var.pagerduty_user_token
}
