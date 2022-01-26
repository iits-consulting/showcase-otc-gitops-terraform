# Either your ACCESS_KEY and SECRET_KEY or from a serviceaccount

export OS_ACCESS_KEY=$(vault kv get --field access_key secret/otc_credentials/playground)
export OS_SECRET_KEY=$(vault kv get --field secret_key secret/otc_credentials/playground)
export AWS_ACCESS_KEY_ID=$OS_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=$OS_SECRET_KEY

export OS_DOMAIN_NAME="OTC-EU-DE-00000000001000055571"
export OS_PROJECT_NAME="eu-de"
export TF_VAR_project_name=${OS_PROJECT_NAME}

export TF_VAR_region="eu-de"

# Current Stage you are working on for example dev,qa, prod etc.
export TF_VAR_stage_name="dev"
#Current Context you are working on can be customer name or cloud name etc.
export TF_VAR_context_name="showcase"

# Pull Secrets for Git and Dockerhub
export TF_VAR_argocd_github_access_token="REPLACE_ME"
export TF_VAR_dockerconfig_json_base64_encoded="REPLACE_ME"