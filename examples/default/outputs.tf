output "webhook_endpoint" {
  value = "${module.lambda.gateway.api_endpoint}/webhook"
}

output "github_app_secret" {
  value = random_password.random.result
}
