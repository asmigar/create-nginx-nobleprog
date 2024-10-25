variable "vpc_cidr_block" {
  type    = string
  default = "10.1.0.0/16"
}

variable "ssh_key_name" {
  type        = string
  default     = "nginx"
  description = "ssh key name to be created in EC2 and store in ~/.ssh folder"
}

variable "organisation" {
  type        = string
  default     = "asmigar"
  description = "org name"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region where resources are to be created"
}

variable "env" {
  type        = string
  default     = "dev"
  description = "environment e.g. dev|qa|prod"
}

variable "additional_vpc_cidr_block" {
  type        = string
  default     = ""
  description = "add additional cidr blocks to vpc"
}
