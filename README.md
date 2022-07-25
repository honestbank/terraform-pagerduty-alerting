# PagerDuty Terraform Component Module

This repository contains the PagerDuty component module meant to be used by layer/other modules to build and manage
PagerDuty resources. This module is not meant to manage live infrastructure on its own. For more details on Terraform
module design please refer to the [Terraform Module Structure page](https://www.notion.so/honestbank/Module-Structure-31374a1594f84ef7b185ef4e06b36619)
in Notion.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_pagerduty"></a> [pagerduty](#requirement\_pagerduty) | >= 2.2 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_pagerduty_token"></a> [pagerduty\_token](#input\_pagerduty\_token) | PagerDuty API token. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
