# Agent Workflow

This repository follows an agentic execution flow for infrastructure automation changes.

## Goal

Provision or destroy an Azure virtual machine from a GitHub Actions pipeline using Terraform.

## Flow

1. Understand request and target cloud/runtime.
2. Define task scope in `task.md`.
3. Confirm required capabilities in `skills.md`.
4. Implement infrastructure code and pipeline.
5. Validate syntax and execution paths.
6. Document setup, secrets, and usage.

## Guardrails

- Keep infrastructure idempotent.
- Keep state remote for CI/CD compatibility.
- Keep workflow manually triggerable with explicit `apply` or `destroy` action.
- Avoid hardcoding credentials; use GitHub secrets only.