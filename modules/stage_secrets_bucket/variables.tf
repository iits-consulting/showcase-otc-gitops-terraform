variable "kms_key_id" {
}

variable "kms_domain_id" {
}

variable "bucket_name" {
  type = string
}

variable "stage_secrets" {
  type = map(string)
}

variable "tags" {
  type = map(string)
  default = null
}