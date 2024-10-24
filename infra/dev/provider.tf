provider "aws" {
  region  = var.aws_region
  profile = var.organisation
  default_tags {
    tags = {
      Organisation = var.organisation
    }
  }
}

terraform {

  backend "s3" {
    key    = "terraform.tfstate"
    bucket = "nobleprog-dev-create-nginx-terraform-state-650251710828"
    region = "us-east-1"
    profile = "nobleprog"
    dynamodb_table = "create-nginx-state-locks"
  }
}
