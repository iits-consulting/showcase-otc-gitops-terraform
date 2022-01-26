terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
    }
    helm = {
      source = "hashicorp/helm"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}
