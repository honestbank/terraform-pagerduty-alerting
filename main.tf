terraform {
  required_version = ">= 1.3.0"
  required_providers {
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = ">= 2.2"
    }
  }
}

provider "pagerduty" {
  token = var.pagerduty_token
}
