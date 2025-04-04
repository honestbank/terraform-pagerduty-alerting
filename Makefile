lint:
	terraform fmt --recursive

validate:
	terraform init
	terraform validate
	terraform fmt --recursive

docs:
	rm -rf modules/*/.terraform modules/*/.terraform.lock.hcl
	rm -rf examples/*/.terraform examples/*/.terraform.lock.hcl
	terraform-docs -c .terraform-docs.yml .
	cd examples/pagerduty-user/; terraform-docs markdown . --output-file README.md --output-mode inject
	cd examples/pagerduty-schedule/; terraform-docs markdown . --output-file README.md --output-mode inject
	cd examples/pagerduty-escalation-policy/; terraform-docs markdown . --output-file README.md --output-mode inject
	cd examples/honest-two-level-schedule/; terraform-docs markdown . --output-file README.md --output-mode inject
	cd examples/pagerduty-service/; terraform-docs markdown . --output-file README.md --output-mode inject
	cd examples/pagerduty-service-integration-email/; terraform-docs markdown . --output-file README.md --output-mode inject

clean:
	rm -rf examples/*/terraform.tfstate examples/*/terraform.tfstate.backup examples/*/.test-data
