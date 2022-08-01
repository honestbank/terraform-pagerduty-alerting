lint:
	terraform fmt --recursive

validate:
	terraform init
	terraform validate
	terraform fmt --recursive

docs:
	terraform-docs -c .terraform-docs.yml .
	cd examples/pagerduty-user/; terraform-docs markdown . --output-file README.md --output-mode inject
	cd examples/pagerduty-schedule/; terraform-docs markdown . --output-file README.md --output-mode inject
	cd examples/pagerduty-escalation-policy/; terraform-docs markdown . --output-file README.md --output-mode inject
	cd examples/honest-two-level-schedule/; terraform-docs markdown . --output-file README.md --output-mode inject
