# Honest Two-level PagerDuty Schedule Example

>
> ⚠️ WARNING: This example can only be used to create and destroy. Modifications that result in removal of users
> from the schedule and their destruction will fail due to a mismanaged dependency (PagerDuty tries to destroy the users
> before removing them from the schedule/s).
>

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
| <a name="module_dummy_team"></a> [dummy\_team](#module\_dummy\_team) | ../../modules/pagerduty-team | n/a |
| <a name="module_dummy_users"></a> [dummy\_users](#module\_dummy\_users) | ../../modules/pagerduty-user | n/a |
| <a name="module_schedule"></a> [schedule](#module\_schedule) | ../../modules/honest-two-level-schedule | n/a |

## Resources

| Name | Type |
|------|------|
| [random_id.random_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dummy_user_count"></a> [dummy\_user\_count](#input\_dummy\_user\_count) | The number of dummy users to create to place into rotation. | `number` | `2` | no |
| <a name="input_name"></a> [name](#input\_name) | The name to set for the schedule. | `string` | n/a | yes |
| <a name="input_pagerduty_token"></a> [pagerduty\_token](#input\_pagerduty\_token) | PagerDuty API token. | `string` | n/a | yes |
| <a name="input_team_name"></a> [team\_name](#input\_team\_name) | The name of the Team to set for the schedule. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dummy_user_ids"></a> [dummy\_user\_ids](#output\_dummy\_user\_ids) | The dummy users created to be placed into rotation. |
| <a name="output_level_one_schedule_id"></a> [level\_one\_schedule\_id](#output\_level\_one\_schedule\_id) | n/a |
| <a name="output_level_two_schedule_id"></a> [level\_two\_schedule\_id](#output\_level\_two\_schedule\_id) | n/a |
| <a name="output_team_id"></a> [team\_id](#output\_team\_id) | n/a |
<!-- END_TF_DOCS -->
