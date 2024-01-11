terraform {
  required_providers {
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = ">= 2.7"
    }
  }
}

provider "pagerduty" {
  token = var.pagerduty_token
}
