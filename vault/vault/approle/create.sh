#!/usr/bin/env bash
set -e

# Source : https://github.com/hashicorp/vault-provision-example/blob/master/scripts/provision.sh

shopt -s nullglob

echo "Verifying Vault is unsealed"
vault status > /dev/null

echo "Get token"
token=$(vault token lookup -format=json | jq -r '.data.id')
echo "> $token"

curl \
  --insecure \
  --location \
  --header "X-Vault-Token: $token" \
  --request POST \
  --data @"/tmp/vault/approle/test_toto.json" \
  "${VAULT_ADDR}/v1/auth/approle/role/test_toto"
