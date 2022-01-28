locals {
  vpc_cidr              = "192.168.0.0/16"
  vpc_subnet_gateway_ip = "192.168.0.1"
  node_spec_default     = "s3.large.4"
  cce_version           = "v1.19.8-r0"
}

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