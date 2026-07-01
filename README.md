# terafarmtes

Terraform + GitHub Actions setup to automatically create or destroy an Azure Linux VM from a pipeline.

## What This Adds

- Terraform code to provision one Azure VM
- Reusable script to run `init/plan/apply/destroy`
- GitHub Actions workflow with manual trigger (`workflow_dispatch`)
- Azure Storage remote backend support for Terraform state (required for CI/CD reliability)
- Agentic workflow docs (`agent.md`, `skills.md`, `task.md`)

## Project Structure

```
.
├── agent.md
├── skills.md
├── task.md
├── .github/workflows/vm-pipeline.yml
├── scripts/terraform_vm.sh
└── terraform
    ├── main.tf
    ├── outputs.tf
    ├── providers.tf
    ├── terraform.tfvars.example
    └── variables.tf
```

## 1) Azure Prerequisites

Create or use an existing Azure setup with:

- A resource group, storage account, and blob container for Terraform remote state
- A service principal with permissions to create and manage VM/network resources
- An SSH public key for Linux VM login

## 2) GitHub Secrets

In your repository, add these secrets:

- `ARM_CLIENT_ID`
- `ARM_CLIENT_SECRET`
- `ARM_SUBSCRIPTION_ID`
- `ARM_TENANT_ID`
- `ARM_ACCESS_KEY` (storage account access key used by Terraform backend)
- `TF_STATE_RESOURCE_GROUP`
- `TF_STATE_STORAGE_ACCOUNT`
- `TF_STATE_CONTAINER`
- `AZURE_SSH_PUBLIC_KEY`

Optional secrets/variables:

- `TF_STATE_KEY` (default: `terafarmtes/vm/terraform.tfstate`)

## 3) Run Pipeline

Go to Actions -> `Provision Azure VM with Terraform` -> `Run workflow`.

Inputs:

- `action`: `apply` or `destroy`
- `location`: Azure region
- `instance_type`: Azure VM size
- `project_name`: Name prefix for tags/resources
- `admin_username`: Linux username for VM login
- `ssh_allowed_cidr`: CIDR allowed for SSH (default `0.0.0.0/0`)

## Local Usage (Optional)

```bash
chmod +x scripts/terraform_vm.sh

export ARM_CLIENT_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
export ARM_CLIENT_SECRET=your-client-secret
export ARM_SUBSCRIPTION_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
export ARM_TENANT_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
export ARM_ACCESS_KEY=your-storage-account-access-key

export TF_STATE_RESOURCE_GROUP=your-tfstate-rg
export TF_STATE_STORAGE_ACCOUNT=yourtfstatestorage
export TF_STATE_CONTAINER=tfstate
export TF_STATE_KEY=terafarmtes/vm/terraform.tfstate

export TF_VAR_project_name=terafarmtes
export TF_VAR_location=eastus
export TF_VAR_instance_type=Standard_B1s
export TF_VAR_admin_username=azureuser
export TF_VAR_admin_ssh_public_key="$(cat ~/.ssh/id_rsa.pub)"
export TF_VAR_ssh_allowed_cidr=0.0.0.0/0

./scripts/terraform_vm.sh apply
./scripts/terraform_vm.sh destroy
```

## Notes

- State is stored in Azure Blob so `destroy` can run in a later pipeline execution.
- VM image defaults to Ubuntu 22.04 LTS.
- Tighten `ssh_allowed_cidr` to your IP/range for better security.