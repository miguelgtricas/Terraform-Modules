variable "vpc_cidr_block" {
    description = "The CIDR block of the VPC"
    type = string
}

variable "domain" {
  description = "The internal domain of the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "subnets_count" {
  description = "Number of subnets to create."
  type        = number
  default     = 1
}

variable "region" {
  description = "AWS region used to deploy the VPC"
  type        = string
}
