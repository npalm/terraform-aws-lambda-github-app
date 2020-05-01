locals {
  webhook_endpoint = "webhook"
  lambda           = var.create_lambda ? aws_lambda_function.webhook[0] : var.lambda
  tags             = merge(var.tags, { Environment = var.environment })
}

resource "aws_apigatewayv2_api" "webhook" {
  name          = "${var.environment}-github-action-webhook"
  protocol_type = "HTTP"
  tags          = local.tags
}

resource "aws_apigatewayv2_route" "webhook" {
  api_id    = aws_apigatewayv2_api.webhook.id
  route_key = "POST /${local.webhook_endpoint}"
  target    = "integrations/${aws_apigatewayv2_integration.webhook.id}"
}

resource "aws_apigatewayv2_stage" "webhook" {
  lifecycle {
    ignore_changes = [
      // see bug https://github.com/terraform-providers/terraform-provider-aws/issues/12893
      default_route_settings
    ]
  }

  api_id      = aws_apigatewayv2_api.webhook.id
  name        = "$default"
  auto_deploy = true
  tags        = local.tags
}

resource "aws_apigatewayv2_integration" "webhook" {
  api_id           = aws_apigatewayv2_api.webhook.id
  integration_type = "AWS_PROXY"

  connection_type    = "INTERNET"
  description        = "GitHub App webhook for receiving events."
  integration_method = "POST"
  integration_uri    = local.lambda.invoke_arn
}

resource "aws_lambda_function" "webhook" {
  count = var.create_lambda ? 1 : 0

  filename         = var.labmda_config.filename
  source_code_hash = filebase64sha256(var.labmda_config.filename)
  function_name    = "${var.environment}-webhook"
  role             = aws_iam_role.webhook_lambda[0].arn
  handler          = var.labmda_config.handler
  runtime          = var.labmda_config.runtime

  environment {
    variables = var.labmda_config.variables
  }
  tags = local.tags
}

resource "aws_lambda_permission" "webhook" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = local.lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.webhook.execution_arn}/*/*/${local.webhook_endpoint}"
}

resource "aws_iam_role" "webhook_lambda" {
  count = var.create_lambda ? 1 : 0

  name               = "${var.environment}-action-webhook-lambda-role"
  assume_role_policy = templatefile("${path.module}/policies/lambda.json", {})
  tags               = local.tags
}

resource "aws_iam_policy" "lambda_logging" {
  count = var.create_lambda ? 1 : 0

  name        = "${var.environment}-lamda-logging-policy"
  description = "Lambda logging policy"

  policy = templatefile("${path.module}/policies/cloudwatch.json", {})
}

resource "aws_iam_policy_attachment" "webhook_logging" {
  count = var.create_lambda ? 1 : 0

  name       = "${var.environment}-logging"
  roles      = [aws_iam_role.webhook_lambda[0].name]
  policy_arn = aws_iam_policy.lambda_logging[0].arn
}


