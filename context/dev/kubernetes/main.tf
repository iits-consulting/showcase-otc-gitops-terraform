data "opentelekomcloud_obs_bucket_object" "stage_secrets" {
  bucket = "${var.context_name}-${var.stage_name}-stage-secrets"
  key    = "terraform-secrets"
}

locals {
  stage_secrets = jsondecode(data.opentelekomcloud_obs_bucket_object.stage_secrets.body)
}

resource "helm_release" "crds" {
  name                  = "crds"
  repository            = "https://iits-consulting.github.io/crds-chart"
  chart                 = "crds"
  version               = "1.1.3"
  namespace             = "crds"
  create_namespace      = true
  render_subchart_notes = true
  dependency_update     = true
}

resource "helm_release" "registry-creds" {
  depends_on            = [helm_release.crds]
  name                  = "registry-creds"
  repository            = "https://iits-consulting.github.io/registry-creds-chart"
  chart                 = "registry-creds"
  version               = "1.0.6"
  namespace             = "registry-creds"
  create_namespace      = true
  atomic                = true
  render_subchart_notes = true
  dependency_update     = true
  set_sensitive {
    name  = "defaultClusterPullSecret.dockerConfigJsonBase64Encoded"
    value = var.dockerconfig_json_base64_encoded
  }
}

module "argocd_configuration_chart" {
  depends_on          = [helm_release.crds]
  source              = "../../../modules/argocd/configuration_chart"
  stage_name          = var.stage_name
  github_access_token = var.argocd_github_access_token
}

module "argocd_chart" {
  depends_on    = [module.argocd_configuration_chart]
  source        = "../../../modules/argocd/chart"
  chart_version = "3.30.0"
}