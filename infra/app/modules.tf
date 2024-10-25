module "aws_networks" {
  source = "../../modules/networking"
}

module "nobleprog_alpha" {
  source   = "cloudposse/label/null"

  name = "nginx"
  namespace = var.organisation
  stage      = terraform.workspace
  delimiter  = "-"
}