terraform {
  required_version = "v1.1.2"
  backend "s3" {
    key = "tfstate"
    bucket = "showcase-dev-tf-remote-state"
    region = "eu-de"
    endpoint = "obs.eu-de.otc.t-systems.com"
    skip_region_validation = true
    skip_credentials_validation = true
    encrypt = true
    kms_key_id = "arn:aws:kms:eu-de:d32336fe26ec415caa04e17e9adfb6a8:key/5e6bf3e3-5543-45f7-b430-366822dc2fb1"
  }
  required_providers {
    external = {
      source  = "hashicorp/external"
      version = "~> 1.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.0"
    }
    opentelekomcloud = {
      source  = "opentelekomcloud/opentelekomcloud"
      version = "1.27.2"
    }
  }
}