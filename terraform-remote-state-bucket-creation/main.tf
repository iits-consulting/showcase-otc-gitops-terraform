terraform {
  required_version = "v1.0.11"
  required_providers {
    opentelekomcloud = {
      source  = "opentelekomcloud/opentelekomcloud"
      version = "1.23.9"
    }
  }
}

locals {
  tenant_name     = "eu-de"
  otc_domain_name = "OTC-EU-DE-00000000001000055571"
  stage_name      = "vault-init"
}

provider "opentelekomcloud" {
  auth_url    = "https://iam.eu-de.otc.t-systems.com/v3"
  domain_name = local.otc_domain_name
  tenant_name = local.tenant_name
}

module "terraform_remote_state_bucket" {
  source           = "iits-consulting/obs-tf-state/opentelekomcloud"
  version          = "1.0.2"
  bucket_name      = "tf-remote-state-${local.stage_name}"
  region           = local.tenant_name
  force_encryption = false
}

output "backend_config" {
  value = module.terraform_remote_state_bucket.backend_config
}
