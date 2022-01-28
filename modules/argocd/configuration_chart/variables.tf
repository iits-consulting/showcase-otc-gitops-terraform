variable "namespace" {
  default     = "argocd"
  description = "The namespace to deploy"
}

variable "github_access_token" {
  sensitive = true
}

variable "stage_name" {
  type = string
}