# Honest Two-level Schedule

This module builds two PagerDuty Schedules using the same responders. The objective is to allow all responders to function
in an L1 as well as L2 roles on different rotations. The same responder cannot be on-call for both schedules at the same
time.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_pagerduty"></a> [pagerduty](#requirement\_pagerduty) | >= 2.7 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_level_one_schedule"></a> [level\_one\_schedule](#module\_level\_one\_schedule) | ../pagerduty-schedule | n/a |
| <a name="module_level_two_schedule"></a> [level\_two\_schedule](#module\_level\_two\_schedule) | ../pagerduty-schedule | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | A description of the schedule. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name to set for the schedules and the schedule layers. | `string` | n/a | yes |
| <a name="input_rotation_turn_length_seconds"></a> [rotation\_turn\_length\_seconds](#input\_rotation\_turn\_length\_seconds) | The time in seconds each individual is on-call for. | `number` | n/a | yes |
| <a name="input_start_datetime"></a> [start\_datetime](#input\_start\_datetime) | The start date and time of the schedule/rotation - format is `2022-03-23T17:00:00+07:00`. | `string` | `"2022-03-23T17:00:00+07:00"` | no |
| <a name="input_team_ids"></a> [team\_ids](#input\_team\_ids) | (Optional) Pagerduty Teams associated with the schedules. | `list(string)` | `[]` | no |
| <a name="input_time_zone"></a> [time\_zone](#input\_time\_zone) | The time zone to set for the schedule (eg. `Asia/Bangkok`). | `string` | `"Asia/Bangkok"` | no |
| <a name="input_user_ids"></a> [user\_ids](#input\_user\_ids) | An ordered list of PagerDuty User IDs to add to the schedule. The individual's order in the schedule depends on the order of this list. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_level_one_schedule_id"></a> [level\_one\_schedule\_id](#output\_level\_one\_schedule\_id) | The `id` attribute of the Level 1 schedule. |
| <a name="output_level_two_schedule_id"></a> [level\_two\_schedule\_id](#output\_level\_two\_schedule\_id) | The `id` attribute of the Level 2 schedule. |
<!-- END_TF_DOCS -->
