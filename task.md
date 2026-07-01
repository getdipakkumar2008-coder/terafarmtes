# Task Definition

## Task

Build Terraform and GitHub Actions automation that can create an Azure virtual machine from a pipeline.

## Deliverables

- Azure Terraform configuration under `terraform/`
- Deployment script under `scripts/`
- GitHub Actions workflow under `.github/workflows/`
- Updated setup and usage documentation in `README.md`

## Acceptance Criteria

- Manual workflow trigger supports `apply` and `destroy`
- Pipeline authenticates to Azure using GitHub secrets
- Terraform uses remote state backend suitable for CI/CD
- VM provisioning includes network, NSG, and public IP for SSH access