# PagerDuty Component Module Tests

This folder contains the tests for all the PagerDuty resources/component modules contained in this repo.

The Terratest automated testing code follows the convention set by the [Terraform PagerDuty Provider](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs)
in that the PagerDuty API token is sourced from the `PAGERDUTY_TOKEN` environment variable.

This value has been set as a GitHub Actions Org-level Secret as `PAGERDUTY_TOKEN` and the current value is set to a development
token generated from Jai's account.
