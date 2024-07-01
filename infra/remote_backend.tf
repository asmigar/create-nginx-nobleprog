data "aws_caller_identity" "current" {}

terraform {
  backend "s3" {
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "create-nginx-state-locks"
  }
}
