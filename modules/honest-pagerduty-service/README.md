# Honest PagerDuty Service Component Module

This module builds a PagerDuty Service + supporting Schedules/Escalation Policies as defined in the [Honest Incident
Management workspace](https://www.notion.so/honestbank/Incident-management-2f2565ef97b148549d7fbe05fc9bfd72).

## Authentication

This module requires a [PagerDuty User-level API key](https://support.pagerduty.com/docs/api-access-keys#section-generating-a-personal-rest-api-key)
for managing the [`pagerduty_slack_connection` Terraform resource](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/slack_connection).

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_pagerduty"></a> [pagerduty](#provider\_pagerduty) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_service"></a> [service](#module\_service) | ../pagerduty-service | n/a |

## Resources

| Name | Type |
|------|------|
| [pagerduty_slack_connection.service_slack_connection_incidents_channel](https://registry.terraform.io/providers/hashicorp/pagerduty/latest/docs/resources/slack_connection) | resource |
| [pagerduty_priority.sev1](https://registry.terraform.io/providers/hashicorp/pagerduty/latest/docs/data-sources/priority) | data source |
| [pagerduty_priority.sev2](https://registry.terraform.io/providers/hashicorp/pagerduty/latest/docs/data-sources/priority) | data source |

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
| <a name="output_service_id"></a> [service\_id](#output\_service\_id) | The `id` attribute of the `pagerduty_service` resource. |
<!-- END_TF_DOCS -->
