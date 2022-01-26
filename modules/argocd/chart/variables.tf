variable "namespace" {
  default     = "argocd"
  description = "The namespace to deploy"
}

variable "chart_version" {
  description = "version of charts"
}
