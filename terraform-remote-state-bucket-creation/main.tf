terraform {
  required_version = "v1.1.2"
  required_providers {
    opentelekomcloud = {
      source  = "opentelekomcloud/opentelekomcloud"
      version = "1.27.3"
    }
  }
}

provider "opentelekomcloud" {
  auth_url    = "https://iam.eu-de.otc.t-systems.com/v3"
}

module "terraform_remote_state_bucket" {
  source           = "iits-consulting/obs-tf-state/opentelekomcloud"
  version          = "1.0.2"
  bucket_name      = "${var.context_name}-${var.stage_name}-tf-remote-state"
  region           = var.region
  force_encryption = true
}

module "terraform_remote_state_bucket_kubernetes" {
  source           = "iits-consulting/obs-tf-state/opentelekomcloud"
  version          = "1.0.2"
  bucket_name      = "${var.context_name}-${var.stage_name}-kubernetes-tf-remote-state"
  region           = var.region
  force_encryption = true
}


output "backend_config" {
  value = module.terraform_remote_state_bucket.backend_config
}

output "backend_config_kubernetes" {
  value = module.terraform_remote_state_bucket_kubernetes.backend_config
}
