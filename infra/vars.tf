variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
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
  type = string
  default = "us-east-1"
  description = "AWS region where resources are to be created"
}

variable "aws_profile" {
  type = string
  default = "asmigar"
  description = "AWS cli profile to be used"
}


variable "env" {
  type = string
  default = "dev"
  description = "environment e.g. dev|qa|prod"
}
