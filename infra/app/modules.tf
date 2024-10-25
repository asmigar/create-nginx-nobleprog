module "aws_networks" {
  source = "../../modules/networking"

  name                      = module.nobleprog_alpha.id
  additional_vpc_cidr_block = var.additional_vpc_cidr_block
}

module "nobleprog_alpha" {
  source = "cloudposse/label/null"

  name      = "nginx"
  namespace = var.organisation
  stage     = terraform.workspace
  delimiter = "-"
}