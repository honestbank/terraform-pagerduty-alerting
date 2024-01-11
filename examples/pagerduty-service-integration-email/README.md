# PagerDuty Service Integrations - Email Example.

This example creates a basic PagerDuty service integration of type `generic_email_inbound_integration`.

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
| <a name="module_engineering_user_one"></a> [engineering\_user\_one](#module\_engineering\_user\_one) | ../../modules/pagerduty-user | n/a |
| <a name="module_escalation_policy"></a> [escalation\_policy](#module\_escalation\_policy) | ../../modules/pagerduty-escalation-policy | n/a |
| <a name="module_level_one_engineering_schedule"></a> [level\_one\_engineering\_schedule](#module\_level\_one\_engineering\_schedule) | ../../modules/pagerduty-schedule | n/a |
| <a name="module_mock_team"></a> [mock\_team](#module\_mock\_team) | ../../modules/pagerduty-team | n/a |
| <a name="module_service"></a> [service](#module\_service) | ../../modules/pagerduty-service | n/a |
| <a name="module_service_email_integration"></a> [service\_email\_integration](#module\_service\_email\_integration) | ../../modules/pagerduty-service-integrations-email | n/a |

## Resources

| Name | Type |
|------|------|
| [random_id.random_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_email_filter"></a> [email\_filter](#input\_email\_filter) | email\_filter = {<br>  from\_email\_regex : "The regex used to match the 'from' field in the inbound email. Should be a valid regex or null"<br>  subject\_regex : "The regex used to match the 'subject' field in the inbound email. Should be a valid regex or null"<br>} | <pre>object({<br>    from_email_regex = string<br>    subject_regex    = string<br>  })</pre> | <pre>{<br>  "from_email_regex": null,<br>  "subject_regex": null<br>}</pre> | no |
| <a name="input_integration_email"></a> [integration\_email](#input\_integration\_email) | This is the unique fully-qualified email address used for routing emails to this integration for processing. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the service integration. | `string` | n/a | yes |
| <a name="input_pagerduty_token"></a> [pagerduty\_token](#input\_pagerduty\_token) | PagerDuty API token. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the service integration. |
| <a name="output_integration_email"></a> [integration\_email](#output\_integration\_email) | This is the unique fully-qualified email address used for routing emails to this integration for processing. |
| <a name="output_integration_id"></a> [integration\_id](#output\_integration\_id) | This is the unique key used to route events to this integration when received via the PagerDuty Events API. |
| <a name="output_service_id"></a> [service\_id](#output\_service\_id) | n/a |
<!-- END_TF_DOCS -->
