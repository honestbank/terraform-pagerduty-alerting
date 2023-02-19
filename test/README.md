# PagerDuty Component Module Tests

>
> ⚠️ WARNING: Some tests may break/become broken due to licensing issues. The current set of tests requires
> 5 full-user licenses which we don't always have available.
>
> We have reached out to PagerDuty to get help with
> a dedicated testing account - https://honest-devops.pagerduty.com (currently on the Free plan, limited to 1 Schedule).
>

This folder contains the tests for all the PagerDuty resources/component modules contained in this repo.

The Terratest automated testing code follows the convention set by the [Terraform PagerDuty Provider](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs)
in that the PagerDuty API token is sourced from the `PAGERDUTY_TOKEN` environment variable.

This value has been set as a GitHub Actions Org-level Secret as `PAGERDUTY_TOKEN` and the current value is set to a development
token generated from Jai's account.

## Running a Specific Test

This folder contains tests for all the modules contained in this repo. These tests are independent and grouped by resource
type/module. This means you won't necessarily need to run all test cases when you're doing some development.

To run a specific test, use the following command:

```go
go test -v -run "TestCaseName$"
```
