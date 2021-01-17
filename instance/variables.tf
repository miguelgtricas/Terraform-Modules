variable "ami_name" {
  description = "Name of the AMI. E.g. ubuntu-bionic-18.04, ubuntu-xenial-16.04. Only required if ami_id is not defined"
  type        = string
  default     = "ubuntu-bionic-18.04"
}

variable "subnet_id" {
  description = "ID of the subnet instance"
}

variable "instance_type" {
  description = "Type of the instance"
  type        = string

  default = "t2.micro"
}

variable "volume_size" {
  description = "Size of the main volume used by the instance"
  type        = string
  default     = "20"
}

variable "instance_name" {
  description = "Name of the instance"
  type        = string
}

variable "volume_name" {
  description = "Name of the volume"
  type        = string
}

variable "route53_zone_id" {
  description = "Zone ID of the record to create"
}

variable "security_groups" {
  description = "Security Group of the instance"
  type = list
}

variable "key_name" {
   description = "The Key Pair name used to connect to the instance"
   type        = string
}

variable "service" {
    description = "Name of the service running inside the instance"
    type = string
}

variable "instance_profile" {
    description = "IAM role assigned to the instance"
    type        = string
}

variable "key_pair_path" {
    description = "Path where the key pair to connect to the instance is located"
}