# PagerDuty Escalation Policy Example

This example creates a 3-level escalation policy - an example screenshot is provided below:

![img.png](example-escalation-policy-screenshot.png)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_pagerduty"></a> [pagerduty](#requirement\_pagerduty) | >= 2.7 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_engineering_lead"></a> [engineering\_lead](#module\_engineering\_lead) | ../../modules/pagerduty-user | n/a |
| <a name="module_engineering_user_one"></a> [engineering\_user\_one](#module\_engineering\_user\_one) | ../../modules/pagerduty-user | n/a |
| <a name="module_engineering_user_two"></a> [engineering\_user\_two](#module\_engineering\_user\_two) | ../../modules/pagerduty-user | n/a |
| <a name="module_escalation_policy"></a> [escalation\_policy](#module\_escalation\_policy) | ../../modules/pagerduty-escalation-policy | n/a |
| <a name="module_level_one_engineering_schedule"></a> [level\_one\_engineering\_schedule](#module\_level\_one\_engineering\_schedule) | ../../modules/pagerduty-schedule | n/a |
| <a name="module_level_three_engineering_schedule"></a> [level\_three\_engineering\_schedule](#module\_level\_three\_engineering\_schedule) | ../../modules/pagerduty-schedule | n/a |
| <a name="module_level_three_product_schedule"></a> [level\_three\_product\_schedule](#module\_level\_three\_product\_schedule) | ../../modules/pagerduty-schedule | n/a |
| <a name="module_level_two_engineering_schedule"></a> [level\_two\_engineering\_schedule](#module\_level\_two\_engineering\_schedule) | ../../modules/pagerduty-schedule | n/a |
| <a name="module_level_two_product_schedule"></a> [level\_two\_product\_schedule](#module\_level\_two\_product\_schedule) | ../../modules/pagerduty-schedule | n/a |
| <a name="module_mock_team"></a> [mock\_team](#module\_mock\_team) | ../../modules/pagerduty-team | n/a |
| <a name="module_product_lead"></a> [product\_lead](#module\_product\_lead) | ../../modules/pagerduty-user | n/a |
| <a name="module_product_manager"></a> [product\_manager](#module\_product\_manager) | ../../modules/pagerduty-user | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | The description to set for the schedule. | `string` | `"example escalation policy description"` | no |
| <a name="input_escalation_delay_in_minutes"></a> [escalation\_delay\_in\_minutes](#input\_escalation\_delay\_in\_minutes) | Minutes until an incident is escalated. | `number` | `60` | no |
| <a name="input_escalation_levels"></a> [escalation\_levels](#input\_escalation\_levels) | Escalation levels and targets | `list` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | The name to set for the schedule. | `string` | `"example escalation policy name"` | no |
| <a name="input_pagerduty_token"></a> [pagerduty\_token](#input\_pagerduty\_token) | PagerDuty API token. | `string` | n/a | yes |
| <a name="input_schedule_suffix"></a> [schedule\_suffix](#input\_schedule\_suffix) | Suffix to the schedule names | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
<!-- END_TF_DOCS -->
