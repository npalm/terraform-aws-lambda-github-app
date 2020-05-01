
resource "random_password" "random" {
  length = 32
}

resource "aws_lambda_function" "webhook" {
  filename         = "${path.module}/../lambda-nodejs-ts/lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/../lambda-nodejs-ts/lambda.zip")
  function_name    = "${local.environment}-webhook"
  role             = aws_iam_role.webhook_lambda.arn
  handler          = "index.handler"
  runtime          = "nodejs12.x"

  environment {
    variables = {
      GITHUB_APP_WEBHOOK_SECRET = random_password.random.result
    }
  }
}

resource "aws_iam_role" "webhook_lambda" {
  name               = "${local.environment}-action-webhook-lambda-role"
  assume_role_policy = templatefile("${path.module}/../../policies/lambda.json", {})
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "${local.environment}-lamda-logging-policy"
  description = "Lambda logging policy"

  policy = templatefile("${path.module}/../../policies/cloudwatch.json", {})
}

resource "aws_iam_policy_attachment" "webhook_logging" {
  name       = "${local.environment}-logging"
  roles      = [aws_iam_role.webhook_lambda.name]
  policy_arn = aws_iam_policy.lambda_logging.arn
}
