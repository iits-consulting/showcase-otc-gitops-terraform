terraform {
  required_version = "v1.1.2"
  backend "s3" {
    #TODO REPLACE_ME
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