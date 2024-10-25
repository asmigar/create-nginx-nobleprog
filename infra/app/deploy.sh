ENV=$1

terraform workspace select $ENV
terraform init -backend-config=$ENV.s3.tfbackend
terraform plan --var-file $ENV.terraform.tfvars
