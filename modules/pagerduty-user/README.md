# PagerDuty User Terraform Component Module

This module creates a PagerDuty user.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_pagerduty"></a> [pagerduty](#requirement\_pagerduty) | >= 2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_pagerduty"></a> [pagerduty](#provider\_pagerduty) | 2.5.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [pagerduty_user.user](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_email_address"></a> [email\_address](#input\_email\_address) | The email adddress of the user | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name to set for the user | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_html_url"></a> [html\_url](#output\_html\_url) | URL at which the entity is uniquely displayed in the Web app |
| <a name="output_id"></a> [id](#output\_id) | The ID of the user |
| <a name="output_invitation_sent"></a> [invitation\_sent](#output\_invitation\_sent) | If true, the user has an outstanding invitation |
<!-- END_TF_DOCS -->
