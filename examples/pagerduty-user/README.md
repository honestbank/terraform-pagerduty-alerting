# PagerDuty User Example

This example creates a basic PagerDuty User.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_pagerduty"></a> [pagerduty](#requirement\_pagerduty) | >= 2.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_user"></a> [user](#module\_user) | ../../modules/pagerduty-user | n/a |

## Resources

| Name | Type |
|------|------|
| [random_id.random_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_email_address"></a> [email\_address](#input\_email\_address) | The email adddress of the user. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name to set for the user. | `string` | n/a | yes |
| <a name="input_pagerduty_token"></a> [pagerduty\_token](#input\_pagerduty\_token) | PagerDuty API token. | `string` | n/a | yes |
| <a name="input_role"></a> [role](#input\_role) | The user's role in PagerDuty. Can be `admin`, `limited_user`, `read_only_user` (Full Stakeholder), or `user`. | `string` | `"user"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_html_url"></a> [html\_url](#output\_html\_url) | URL at which the entity is uniquely displayed in the Web app. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the user. |
| <a name="output_invitation_sent"></a> [invitation\_sent](#output\_invitation\_sent) | If true, the user has an outstanding invitation. |
<!-- END_TF_DOCS -->
