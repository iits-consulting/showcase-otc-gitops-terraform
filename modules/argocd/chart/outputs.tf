data "kubernetes_secret" "argocd_admin_password" {
  metadata {
    name = "argocd-initial-admin-secret"
    namespace = "argocd"
  }
}

output "argocd_admin_password" {
  value = data.kubernetes_secret.argocd_admin_password.data
  sensitive = true
}