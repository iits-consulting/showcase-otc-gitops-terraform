terraform {
  required_version = "v1.1.2"
  backend "s3" {
    #REPLACE_ME
  }
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.0.0"
    }
    opentelekomcloud = {
      source  = "opentelekomcloud/opentelekomcloud"
      version = "1.27.3"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.7.1"
    }

    helm = {
      source = "hashicorp/helm"
      version = "2.4.1"
    }
  }
}