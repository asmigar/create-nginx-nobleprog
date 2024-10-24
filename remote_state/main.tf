provider "aws" {
  region  = "us-east-1"
  profile = "asmigar"
  default_tags {
    tags = {
      Organisation = "Asmigar"
    }
  }
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "terraform_state" {
  count  = length(var.envs)
  bucket = "${var.organisation}-${var.envs[count.index]}-create-nginx-terraform-state-${data.aws_caller_identity.current.account_id}"

  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  count  = length(var.envs)
  bucket = aws_s3_bucket.terraform_state[count.index].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Enable versioning so we can see the full revision history of our state files
resource "aws_s3_bucket_versioning" "terraform_state" {
  count  = length(var.envs)
  bucket = aws_s3_bucket.terraform_state[count.index].id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "create-nginx-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
