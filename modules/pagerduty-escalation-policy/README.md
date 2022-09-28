# PagerDuty Escalation Policy Component Module

This module creates a PagerDuty Escalation Policy.

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
| [pagerduty_escalation_policy.escalation_policy](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/escalation_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | A description of the schedule. | `string` | n/a | yes |
| <a name="input_escalation_delay_in_minutes"></a> [escalation\_delay\_in\_minutes](#input\_escalation\_delay\_in\_minutes) | The escalation delay between each layer of the escalation policy. | `any` | n/a | yes |
| <a name="input_escalation_levels"></a> [escalation\_levels](#input\_escalation\_levels) | A list of a list of schedules. The outer list is mapped to escalation rules, while the inner list represents multiple targets in the same escalation level. | `list(list(string))` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name to set for the schedules and the schedule layers. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The `id` attribute of the escalation policy. |
<!-- END_TF_DOCS -->
