# PagerDuty User Example

This example creates a basic PagerDuty User.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_pagerduty"></a> [pagerduty](#requirement\_pagerduty) | >= 2.2 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_user"></a> [user](#module\_user) | ../../modules/pagerduty-user | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_email_address"></a> [email\_address](#input\_email\_address) | The email adddress of the user | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name to set for the user | `string` | n/a | yes |
| <a name="input_pagerduty_token"></a> [pagerduty\_token](#input\_pagerduty\_token) | PagerDuty API token. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
