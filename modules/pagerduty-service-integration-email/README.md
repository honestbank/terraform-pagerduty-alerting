## PagerDuty Email Service Integration

A `pagerduty-service-integration-email` is a [`pagerduty_service_integration`](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/service_integration) of the type `generic_email_inbound_integration`. Use this module to trigger incidents via email messages.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_pagerduty"></a> [pagerduty](#requirement\_pagerduty) | >= 2.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_pagerduty"></a> [pagerduty](#provider\_pagerduty) | >= 2.7 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [pagerduty_service_integration.generic_email_inbound_integration](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/service_integration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_email_filter"></a> [email\_filter](#input\_email\_filter) | email\_filter = {<br/>  from\_email\_regex : "The regex used to match the 'from' field in the inbound email. Should be a valid regex or null"<br/>  subject\_regex : "The regex used to match the 'subject' field in the inbound email. Should be a valid regex or null"<br/>} | <pre>object({<br/>    from_email_regex = string<br/>    subject_regex    = string<br/>  })</pre> | <pre>{<br/>  "from_email_regex": null,<br/>  "subject_regex": null<br/>}</pre> | no |
| <a name="input_email_incident_creation"></a> [email\_incident\_creation](#input\_email\_incident\_creation) | Behaviour of Email Management feature (explained in PD docs)[https://support.pagerduty.com/docs/email-management-filters-and-rules#control-when-a-new-incident-or-alert-is-triggered]. Can be on\_new\_email, on\_new\_email\_subject, only\_if\_no\_open\_incidents or use\_rules. | `string` | `"use_rules"` | no |
| <a name="input_integration_email"></a> [integration\_email](#input\_integration\_email) | This is the unique fully-qualified email address used for routing emails to this integration for processing. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the service integration. | `string` | n/a | yes |
| <a name="input_service_id"></a> [service\_id](#input\_service\_id) | The ID of the service the integration should belong to. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the service integration. |
| <a name="output_integration_email"></a> [integration\_email](#output\_integration\_email) | This is the unique fully-qualified email address used for routing emails to this integration for processing. |
<!-- END_TF_DOCS -->
