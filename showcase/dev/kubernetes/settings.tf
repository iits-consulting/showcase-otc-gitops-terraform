terraform {
  required_version = "v1.1.2"
  backend "s3" {
    key = "tfstate"
    bucket = "showcase-dev-tf-remote-state-kubernetes"
    region = "eu-de"
    endpoint = "obs.eu-de.otc.t-systems.com"
    skip_region_validation = true
    skip_credentials_validation = true
    encrypt = true
    kms_key_id = "arn:aws:kms:eu-de:d32336fe26ec415caa04e17e9adfb6a8:key/5a5e9884-d480-4d37-921e-08ff2e537afd"
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
  }
}