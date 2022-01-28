
resource "helm_release" "argo_config" {
  name      = "argocd-config"
  chart     = "${path.module}/argocd-config"
  namespace = var.namespace
  values = [
    sensitive(templatefile(
      "${path.module}/argocd-config/values.yaml",
      {
        ARGOCD_GITHUB_ACCESS_TOKEN        = var.github_access_token
        STAGE                             = var.stage_name
      }
    ))
  ]
  create_namespace      = true
  render_subchart_notes = false
  dependency_update     = false
}
