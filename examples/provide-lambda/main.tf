locals {
  aws_region  = "eu-west-1"
  environment = "test"
}

module "lambda" {
  source = "../../"

  environment   = local.environment
  create_lambda = false
  lambda        = aws_lambda_function.webhook
}
