variable "namespace" {
  type        = string
  default     = ""
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "stage" {
  type        = string
  default     = ""
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
}

variable "name" {
  type        = string
  default     = ""
  description = "Solution name, e.g. 'app' or 'jenkins'"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "aws_key_name" {
  description = "SSH keypair name for the VPN instance"
}

variable "vpc_id" {
  description = "Which VPC VPN server will be created in"
}

variable "public_subnet_id" {
  description = "One of the public subnet id for the VPN instance"
}

variable "instance_type" {
  description = "Instance type for VPN Box"
  type        = string
  default     = "t2.micro"
}

variable "whitelist" {
  description = "[List] Office IP CIDRs for SSH and HTTPS"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}


variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "resource_name_prefix" {
  description = "All the resources will be prefixed with the value of this variable"
  default     = "pritunl"
}

variable "internal_cidrs" {
  description = "[List] IP CIDRs to whitelist in the pritunl's security group"
  type        = list(string)
  default     = ["172.0.0.0/8"]
}