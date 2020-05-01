locals {
  aws_region = "eu-west-1"
}

resource "random_password" "random" {
  length = 32
}

module "lambda" {
  source = "../../"

  environment = "test"
  labmda_config = {
    filename = "${path.module}/../lambda-nodejs-ts/lambda.zip"
    handler  = "index.handler"
    runtime  = "nodejs12.x"
    variables = {
      GITHUB_APP_WEBHOOK_SECRET = random_password.random.result
    }
  }
}
