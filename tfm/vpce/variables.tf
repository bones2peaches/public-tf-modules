variable "env" {
  description = "Environment name."
  type        = string
}

variable "project" {
    description = "prefix for resources for a given project"
    type = string
}


variable "route_table_ids" {
  description = "route table ids used for routing s3 gateway vpce."
  type        = list(string)
}

variable "region_names" {
  description = "list of regions you want to deploy the vpce."
  type        = list(string)
}

variable "vpc_id" {
  description = "vpc id for vpces."
  type = string
}

variable "subnet_ids" {
  description = "private subnet ids for "
  type = list(string)
}

variable "allowed_sgs" {
  description = "list of security groups allowed to access the vpce on port 443"
  type        = list(string)
}

