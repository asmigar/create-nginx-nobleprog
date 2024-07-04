terraform {
  source = "../../modules//nginx"
}

locals {
  env = "prod"
}

inputs = {
  env = local.env
}