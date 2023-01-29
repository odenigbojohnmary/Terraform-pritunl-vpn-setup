variable "project_id" {
  type = string
  description = "The project ID to host the network in."
}

variable "region" {
  type = string
  description = "The region to use"
}

variable "zone" {
  type = string
  description = "The zone where the pritunl_vpn host is located in."
}

variable "vpn_name" {
  type = string
  description = "The name to use for the pritunl_vpn instance."
}

variable "network_name" {
  type = string
  description = "The name of the network that should be used."
}

variable "subnet_name" {
  type = string
  description = "The name of the subnet that should be used."
}