# Terraform Component Module Template Repository

Use this repository as a starting point for building a [Terraform Component Module](https://www.notion.so/honestbank/WIP-How-to-structure-a-Terraform-module-31374a1594f84ef7b185ef4e06b36619).

The recommended usage is to make this a public [Trunk-Based Development](https://trunkbaseddevelopment.com) repo that
automatically releases using SemVer on merge to trunk (typically called `main`). This module is then embedded and
instantiated by Layer Modules to manage live infrastructure.

## Customizations

### Pre-commit

This template contains a [.pre-commit-config.yaml file](./.pre-commit-config.yaml). To use this, please [install pre-commit](https://pre-commit.com/#install)
and run `pre-commit install` to install hooks. The default set of hooks should work for most Terraform modules/repos - please
customize as needed.

### Releases

This template contains a [semantic-release](https://github.com/semantic-release/semantic-release) [configuration file](./release.config.js)
that is configured to produce releases on merge to `main`.

### GitHub Actions

This template contains [a 'terraform' action/workflow](./.github/workflows/terraform.yml) that is configured to run on
PRs and pushes to `main` and is designed around a [Trunk-Based Development](https://trunkbaseddevelopment.com) workflow.
