terraform {
  required_providers {
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = ">= 2.2"
    }
  }

  experiments = [module_variable_optional_attrs]
}
