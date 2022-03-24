# PagerDuty Terraform Component Module

This repository contains the PagerDuty component module meant to be used by layer/other modules to build and manage
PagerDuty resources. This module is not meant to manage live infrastructure on its own. For more details on Terraform
module design please refer to the [Terraform Module Structure page](https://www.notion.so/honestbank/Module-Structure-31374a1594f84ef7b185ef4e06b36619)
in Notion.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_pagerduty"></a> [pagerduty](#requirement\_pagerduty) | >= 2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_pagerduty"></a> [pagerduty](#provider\_pagerduty) | 2.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [pagerduty_escalation_policy.engineering_escalation_policy](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/escalation_policy) | resource |
| [pagerduty_schedule.engineering_level_one_schedule](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/schedule) | resource |
| [pagerduty_schedule.engineering_level_two_schedule](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/schedule) | resource |
| [pagerduty_service.honest_card_apis_qa](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/service) | resource |
| [pagerduty_service_event_rule.qa_priority_hours_rule](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/service_event_rule) | resource |
| [pagerduty_user.devops_test_user_one](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/user) | resource |
| [pagerduty_user.devops_test_user_two](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/user) | resource |
| [pagerduty_user.level_one_responders](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/user) | resource |
| [pagerduty_user.level_two_responders](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_pagerduty_responders_engineers_level_one"></a> [pagerduty\_responders\_engineers\_level\_one](#input\_pagerduty\_responders\_engineers\_level\_one) | List of PagerDuty L1 responders. | <pre>list(object({<br>    name  = string<br>    email = string<br>    role  = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_pagerduty_responders_engineers_level_two"></a> [pagerduty\_responders\_engineers\_level\_two](#input\_pagerduty\_responders\_engineers\_level\_two) | List of PagerDuty L2 responders. | <pre>list(object({<br>    name  = string<br>    email = string<br>    role  = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_pagerduty_token"></a> [pagerduty\_token](#input\_pagerduty\_token) | PagerDuty API token. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
