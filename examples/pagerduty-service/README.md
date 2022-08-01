# PagerDuty Service Example

This example creates a PagerDuty Service (along with the required escalation policy).

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_escalation_policy"></a> [escalation\_policy](#module\_escalation\_policy) | ../pagerduty-escalation-policy | n/a |
| <a name="module_service"></a> [service](#module\_service) | ../../modules/pagerduty-service | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | The description to set for the schedule. | `string` | `"example escalation policy description"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name to set for the schedule. | `string` | `"example escalation policy name"` | no |
| <a name="input_pagerduty_token"></a> [pagerduty\_token](#input\_pagerduty\_token) | PagerDuty API token. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_id"></a> [service\_id](#output\_service\_id) | n/a |
<!-- END_TF_DOCS -->
