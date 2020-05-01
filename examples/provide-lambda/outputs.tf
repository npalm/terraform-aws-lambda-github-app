output "api_gateway_endpoint" {
  value = module.lambda.gateway.api_endpoint
}

output "github_app_secret" {
  value = random_password.random.result
}
