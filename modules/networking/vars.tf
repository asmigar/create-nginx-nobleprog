variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "name" {
  type    = string
  default = "main"
}

variable "additional_vpc_cidr_block" {
  type    = string
  default = ""
}