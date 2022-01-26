BUCKET_NAME=${TF_VAR_context_name}-${TF_VAR_stage_name}-stage-secrets
path="/stage-secrets"
current_date=$(date +'%a, %d %b %Y %H:%M:%S %z')
request_string="GET\n\n\n${current_date}\n/${BUCKET_NAME}${path}"
echo -en "${request_string}"
signed_reqest=$(echo -en "${request_string}" | openssl sha1 -hmac "${AWS_SECRET_ACCESS_KEY}" -binary | base64)
curl -H "Host: ${BUCKET_NAME}.obs.eu-de.otc.t-systems.com" \
     -H "Date: $current_date" \
     -H "Authorization: AWS ${AWS_ACCESS_KEY_ID}:${signed_reqest}" \
     "${BUCKET_NAME}.obs.eu-de.otc.t-systems.com${path}" | jq -r ."kubectlConfig" > ~/.kube/config || true
kubectl config set-context $STAGE_NAME --namespace=default