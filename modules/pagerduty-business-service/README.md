# PagerDuty Business Service Component Module

This module creates a [PagerDuty Business Service](https://support.pagerduty.com/docs/business-services) using the 
[`pagerduty_business_service` resource](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/business_service),
as well as attaches dependencies that feed in to the business service using the [`pagerduty_service_dependency` resource](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/service_dependency).

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
| [pagerduty_business_service.business_service](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/business_service) | resource |
| [pagerduty_service_dependency.supporting_business_services](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/service_dependency) | resource |
| [pagerduty_service_dependency.supporting_services](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/service_dependency) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | The description of the business service. If not set, a placeholder of `Managed by Terraform` will be set. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the business service. | `string` | n/a | yes |
| <a name="input_owner_team_id"></a> [owner\_team\_id](#input\_owner\_team\_id) | ID of the team that owns this business service. | `string` | n/a | yes |
| <a name="input_point_of_contact"></a> [point\_of\_contact](#input\_point\_of\_contact) | A string/text description of who to contact regarding this business service. | `string` | `null` | no |
| <a name="input_supporting_business_service_ids"></a> [supporting\_business\_service\_ids](#input\_supporting\_business\_service\_ids) | A list of PagerDuty business service IDs to set as supporting services for this business services. Only business services are supported - to set normal PagerDuty supporting services use the `supporting_service_ids` variable. | `list(string)` | `[]` | no |
| <a name="input_supporting_service_ids"></a> [supporting\_service\_ids](#input\_supporting\_service\_ids) | A list of PagerDuty service IDs to set as supporting services for this business service. Note that these need to be regular PagerDuty services (non-business services). For supporting business services use the `supporting_business_service_ids` variable. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_html_url"></a> [html\_url](#output\_html\_url) | A URL at which the entity is uniquely displayed in the PagerDuty web UI. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the business service. |
| <a name="output_self"></a> [self](#output\_self) | The API show URL at which the object is accessible. |
| <a name="output_summary"></a> [summary](#output\_summary) | A short-form, server-generated string that provides succinct, important information about an object suitable for primary labeling of an entity in a client. In many cases, this will be identical to name, though it is not intended to be an identifier. |
<!-- END_TF_DOCS -->
