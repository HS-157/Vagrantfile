#!/usr/bin/env bash
set -e

# Source : https://github.com/hashicorp/vault-provision-example/blob/master/scripts/provision.sh

shopt -s nullglob

function provision() {
  set +e
  pushd "$1" > /dev/null
  for f in $(ls "$1"/*.json); do
    p="$1/${f%.json}"
    echo "Provisioning $p"
    curl \
      --insecure \
      --location \
      --header "X-Vault-Token: $token" \
      --data @"${f}" \
      "${VAULT_ADDR}/v1/${p}"
  done
  popd > /dev/null
  set -e
}

echo "Verifying Vault is unsealed"
vault status > /dev/null

echo "Get token"
token=$(vault token lookup -format=json | jq -r '.data.id')
echo "> $token"

pushd /tmp/vault >/dev/null

provision secret/postgresql

popd > /dev/null
