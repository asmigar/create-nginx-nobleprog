terraform {
  source = "../../modules//nginx"
}

inputs = {
  env = "prod"
}