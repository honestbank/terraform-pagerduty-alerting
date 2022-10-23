# PagerDuty Team Component Module

This module creates a PagerDuty team using the [`pagerduty_team` resource](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/team).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_pagerduty"></a> [pagerduty](#requirement\_pagerduty) | >= 2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_pagerduty"></a> [pagerduty](#provider\_pagerduty) | >= 2.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [pagerduty_team.team](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/team) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | A description of the team. If not set, a placeholder of `Managed by Terraform` will be set. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the team. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_html_url"></a> [html\_url](#output\_html\_url) | URL at which the entity is uniquely displayed in the PagerDuty web UI. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the team. |
<!-- END_TF_DOCS -->
