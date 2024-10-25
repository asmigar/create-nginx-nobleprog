provider "aws" {
  region  = var.aws_region
  default_tags {
    tags = {
      Organisation = var.organisation
      Env          = terraform.workspace
    }
  }
}

terraform {

  backend "s3" {
    key = "terraform.tfstate"
    #    bucket = "nobleprog-dev-create-nginx-terraform-state-650251710828"
    region         = "us-east-1"
    dynamodb_table = "create-nginx-state-locks"
  }
}
