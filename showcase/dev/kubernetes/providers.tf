provider "opentelekomcloud" {
  auth_url    = "https://iam.eu-de.otc.t-systems.com/v3"
  max_retries = 100
}

provider "kubernetes" {
  host               = local.stage_secrets["kubernetesEndpoint"]
  load_config_file   = "false"
  client_certificate = local.stage_secrets["kubernetesClientCertificate"]
  client_key         = local.stage_secrets["kubernetesClientKey"]
  insecure           = true
  config_context_cluster = var.stage_name
}

provider "helm" {
  kubernetes {
    host               = local.stage_secrets["kubernetesEndpoint"]
    client_certificate = local.stage_secrets["kubernetesClientCertificate"]
    client_key         = local.stage_secrets["kubernetesClientKey"]
    insecure           = true
    config_context_cluster = var.stage_name
  }
}