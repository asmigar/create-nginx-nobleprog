variable "organisation" {
  default     = "nobleprog"
  type        = string
  description = "org name to use as s3 bucket prefix"
}

variable "region" {
  default     = "us-east-1"
  type        = string
  description = "region to be used for resource creation"
}

variable "envs" {
  default     = ["dev"]
  type        = list(string)
  description = "list of environments to be created"
}