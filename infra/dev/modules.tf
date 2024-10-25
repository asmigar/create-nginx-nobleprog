module "aws_networks" {
  source = "../../modules/networking"
}

module "dev_nobleprog_alpha" {
  source   = "cloudposse/label/null"

  name = "nginx"
  namespace = var.organisation
  stage      = var.env
  delimiter  = "-"
}