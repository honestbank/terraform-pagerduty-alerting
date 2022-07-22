# This file is only present to allow pre-commit to pass. This file is not needed for any tests.
# ################################################################################################

terraform {
  required_providers {
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = ">= 2.2"
    }
  }

  experiments = [module_variable_optional_attrs]
}
