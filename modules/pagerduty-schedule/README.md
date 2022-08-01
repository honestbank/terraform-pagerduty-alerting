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
| [pagerduty_schedule.schedule](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/schedule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | A description of the schedule. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name to set for the schedule and the base layer. | `string` | n/a | yes |
| <a name="input_rotation_turn_length_seconds"></a> [rotation\_turn\_length\_seconds](#input\_rotation\_turn\_length\_seconds) | The time in seconds each individual is on-call for. | `number` | n/a | yes |
| <a name="input_start_datetime"></a> [start\_datetime](#input\_start\_datetime) | The start date and time of the schedule/rotation - format is `2022-03-23T17:00:00+07:00`. | `string` | n/a | yes |
| <a name="input_time_zone"></a> [time\_zone](#input\_time\_zone) | The time zone to set for the schedule (eg. `Asia/Bangkok`). | `string` | n/a | yes |
| <a name="input_user_ids"></a> [user\_ids](#input\_user\_ids) | An ordered list of PagerDuty User IDs to add to the schedule. The individual's order in the schedule depends on the order of this list. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The `id` attribute of the schedule. |
<!-- END_TF_DOCS -->
