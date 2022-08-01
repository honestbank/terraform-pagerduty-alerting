# PagerDuty Schedule Example

This example creates a basic PagerDuty Schedule.

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
| <a name="module_schedule"></a> [schedule](#module\_schedule) | ../../modules/pagerduty-schedule | n/a |
| <a name="module_user_one"></a> [user\_one](#module\_user\_one) | ../../modules/pagerduty-user | n/a |
| <a name="module_user_two"></a> [user\_two](#module\_user\_two) | ../../modules/pagerduty-user | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name to set for the schedule. | `string` | n/a | yes |
| <a name="input_pagerduty_token"></a> [pagerduty\_token](#input\_pagerduty\_token) | PagerDuty API token. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_schedule_id"></a> [schedule\_id](#output\_schedule\_id) | The `id` attribute of the schedule. |
| <a name="output_user_one_id"></a> [user\_one\_id](#output\_user\_one\_id) | Dummy user created for inserting into the schedule. |
| <a name="output_user_two_id"></a> [user\_two\_id](#output\_user\_two\_id) | Dummy user created for inserting into the schedule. |
<!-- END_TF_DOCS -->
