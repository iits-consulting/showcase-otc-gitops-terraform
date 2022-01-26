variable "stage_name" {
  type = string
  description = "Current Stage you are working on for example dev,qa, prod etc."
}

variable "context_name" {
  type = string
  description = "Current Context you are working on can be customer name or cloud name etc."
}

variable "region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "dockerconfig_json_base64_encoded" {
  type = string
}

variable "argocd_github_access_token" {
  type = string
}