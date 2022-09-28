# PagerDuty Service Component Module

This module creates a PagerDuty Service.

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
| [pagerduty_service.service](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acknowledgement_timeout"></a> [acknowledgement\_timeout](#input\_acknowledgement\_timeout) | Time in seconds that an incident changes to the Triggered State after being Acknowledged. Set to 0 to disable. | `any` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | A description of the service. | `string` | n/a | yes |
| <a name="input_escalation_policy_id"></a> [escalation\_policy\_id](#input\_escalation\_policy\_id) | The escalation policy to use for this service. | `string` | n/a | yes |
| <a name="input_incident_urgency_rule_constant_urgency_value"></a> [incident\_urgency\_rule\_constant\_urgency\_value](#input\_incident\_urgency\_rule\_constant\_urgency\_value) | The urgency: low Notify responders (does not escalate), high (follows escalation rules) or severity\_based Set's the urgency of the incident based on the severity set by the triggering monitoring tool. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the service. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The `id` attribute of the service. |
<!-- END_TF_DOCS -->
