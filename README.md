# This is a blueprint to start easy and fast with OTC Terraform

- You will need a dockerconfig_json_base64_encoded which contains the pullsecret informations for the public dockerhub.
- You will need a gitlab or github access token to be able to pull the information from you git repositories.
- Rename the folder /context to your contextname
- Add the stage under your newly created contextfolder (for example showcase/dev)

## Deploy Infrastructure
1. Adjust set-env.sh
    1. ACCESS_KEY and SECRET_KEY you get from the OTC UI
2. Source set-env.sh
3. Go to terraform-remote-state-bucket-creation and execute terraform init and apply
4. You will get two outputs which you need to put inside ${context}/${stage}/settings.tf
5. Go into the folder ${context}/${stage} (in this example it is showcase/dev)
6. Adjust variables.tf to your needs
7. Execute Terraform init and apply
    1. It will take like 10-15 Minutes till everything is up
8. Look if the stage-secrets bucket was created


## Deploy GitOps and ArgoCD
1. Adjust modules/argocd/configuration_chart/values.yaml
    1. Set infrastructure.repoUrl
    2. Set infrastructure.path
    3. Set infrastructure.name
2. Go into the folder ${context}/${stage}/kubernetes
3. Execute Terraform init and apply
4. Now ArgoCD should boot up successfully

## Access ArgoCD UI
- kubectl -n argocd port-forward svc/argocd-server 8080:443
- http://localhost:8080
    - Username=admin
    - Password= kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d