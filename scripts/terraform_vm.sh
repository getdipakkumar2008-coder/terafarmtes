#!/usr/bin/env bash

set -euo pipefail

ACTION="${1:-apply}"

if [[ "$ACTION" != "apply" && "$ACTION" != "destroy" ]]; then
  echo "Usage: $0 [apply|destroy]"
  exit 1
fi

TF_DIR="terraform"

if [[ ! -d "$TF_DIR" ]]; then
  echo "Expected Terraform directory '$TF_DIR' not found"
  exit 1
fi

if [[ -z "${TF_STATE_RESOURCE_GROUP:-}" || -z "${TF_STATE_STORAGE_ACCOUNT:-}" || -z "${TF_STATE_CONTAINER:-}" ]]; then
  echo "Missing backend settings. Export TF_STATE_RESOURCE_GROUP, TF_STATE_STORAGE_ACCOUNT, and TF_STATE_CONTAINER."
  exit 1
fi

TF_STATE_KEY="${TF_STATE_KEY:-terafarmtes/vm/terraform.tfstate}"

pushd "$TF_DIR" >/dev/null

terraform init -input=false \
  -backend-config="resource_group_name=${TF_STATE_RESOURCE_GROUP}" \
  -backend-config="storage_account_name=${TF_STATE_STORAGE_ACCOUNT}" \
  -backend-config="container_name=${TF_STATE_CONTAINER}" \
  -backend-config="key=${TF_STATE_KEY}"

terraform fmt -check
terraform validate

if [[ "$ACTION" == "apply" ]]; then
  terraform plan -input=false -out=tfplan
  terraform apply -input=false -auto-approve tfplan
else
  terraform plan -destroy -input=false -out=tfdestroy
  terraform apply -input=false -auto-approve tfdestroy
fi

popd >/dev/null