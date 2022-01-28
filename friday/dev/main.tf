module "ssh_keypair" {
  source       = "iits-consulting/project-factory/opentelekomcloud//modules/ssh_keypair"
  version      = "1.3.2"
  stage_name   = var.stage_name
  context_name = var.context_name
  region       = var.region
}

module "vpc" {
  source                = "iits-consulting/project-factory/opentelekomcloud//modules/vpc"
  version               = "1.3.2"
  vpc_cidr              = local.vpc_cidr
  vpc_name              = "vpc-${var.context_name}-${var.stage_name}"
  stage_name            = var.stage_name
  vpc_subnet_cidr       = local.vpc_cidr
  vpc_subnet_gateway_ip = local.vpc_subnet_gateway_ip
  region                = var.region
}

module "cce" {
  source                  = "iits-consulting/project-factory/opentelekomcloud//modules/cce"
  version                 = "1.3.2"
  key_pair_id             = module.ssh_keypair.keypair_name
  stage_name              = var.stage_name
  subnet_id               = module.vpc.subnet_network_id
  vpc_id                  = module.vpc.vpc_id
  vpc_cidr                = local.vpc_cidr
  nodes                   = [local.node_spec_default, local.node_spec_default]
  cce_version             = local.cce_version
  context_name            = var.context_name
  cce_authentication_mode = "x509"
}

module "loadbalancer" {
  source       = "iits-consulting/project-factory/opentelekomcloud//modules/loadbalancer"
  version      = "1.3.2"
  context_name = var.context_name
  subnet_id    = module.vpc.subnet_id
  stage_name   = var.stage_name
  bandwidth    = 1000
}

module "stage_secrets_to_encrypted_s3_bucket" {
  providers   = { opentelekomcloud = opentelekomcloud.top_level_project }
  source               = "iits-consulting/project-factory/opentelekomcloud//modules/encrypted_bucket"
  version              = "1.3.2"
  bucket_name   = "${var.context_name}-${var.stage_name}-stage-secrets"
  region = var.region
  secrets     = {
    kubectlConfig               = module.cce.kubectl_config
    elbId                       = module.loadbalancer.elb_id
    elbPublicIp                 = module.loadbalancer.elb_public_ip
    kubernetesEndpoint          = module.cce.kube_api_endpoint
    kubernetesClientCertificate = base64decode(module.cce.client-certificate)
    kubernetesClientKey         = base64decode(module.cce.client-key)
    kubernetesCaCert            = base64decode(module.cce.client-key)
  }
}