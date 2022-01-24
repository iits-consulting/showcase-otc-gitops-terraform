sudo sh -c "echo VAULT_ADDR="https://vault.guardians-of-the-otc.com" >> /etc/environment" && source /etc/environment
unset VAULT_TOKEN
vault login -method=oidc -path=keycloak role=admin
sudo sh -c "echo VAULT_TOKEN=$(cat ~/.vault-token) >> /etc/environment"
sudo sh -c "echo TF_VAR_vault_token=$(cat ~/.vault-token) >> /etc/environment" && source /etc/environment
export ACCESS_KEY=$(vault kv get --field access_key secret/otc_credentials/presentation)
export SECRET_KEY=$(vault kv get --field secret_key secret/otc_credentials/presentation)
export OS_ACCESS_KEY=$ACCESS_KEY
export OS_SECRET_KEY=$SECRET_KEY
export AWS_ACCESS_KEY_ID=$ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=$SECRET_KEY
export OS_PROJECT_NAME="eu-de_presentation"