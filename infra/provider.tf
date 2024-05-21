provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
  default_tags {
    tags = {
      Organisation = var.organisation
      Environment  = var.env
      Managed_By   = "Terraform v1.5.7"
    }
  }
}
