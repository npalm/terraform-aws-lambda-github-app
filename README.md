# Terraform module for AWS lambda to receive GitHub App events

This module creates the required infra to handle events of GitHub app via a Lambda connected to API Gateway V2.

The module will create by default an API Gateway with a route on `webhook` for HTTP Post. Requests sent to this webhook will be sent to the lambda. The example lambda will check the GitHub secret.

## Usages

To create a lambda and API gateway endpoint.

```terraform
module "lambda-github-app" {
  source = "npalm/lambda-github-app/aws"

  environment = "test"
  labmda_config = {
    filename = "lambda.zip"
    handler  = "index.handler"
    runtime  = "nodejs12.x"
    variables = {
      GITHUB_APP_WEBHOOK_SECRET = "my-secret"
    }
  }
}

```

## Examples

- _[default](./examples/default/)_ : Example that will create the lambda based on provided config and a zip file.
- _[provided-](./examples/provide-lambda/)_ : Example that will let you create the lambda resource and pass the resource to the module. The module will create the API gateway for you.

### Prerequisite:

- Terraform 0.12.x
- Docker for building the example lambda
- Amazon account for deployment
- GitHub account for creating an app

### Usages

```bash
# build the lambda
cd examples/lambda-nodejs-ts
./build.sh

## create infra
cd ../default
terraform init
terraform apply
```

Terraform will output the webhook endpoint and secret for the GitHub. Go to https://github.com/settings/apps and create your app.

## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| aws  | n/a     |

## Inputs

| Name          | Description                                                                                                         | Type                                                                                                                   | Default | Required |
| ------------- | ------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| environment   | Name of the environment will be used to name resources unique.                                                      | `string`                                                                                                               | n/a     |   yes    |
| create_lambda | Let the module create the lambda, provide the config for the lambda via `lambda_config`.                            | `bool`                                                                                                                 | `true`  |    no    |
| labmda_config | Configuration for the lambda. Only required if `create_lambda` is set to `true`.                                    | <pre>object({<br> filename = string<br> handler = string<br> runtime = string<br> variables = map(string)<br> })</pre> | `null`  |    no    |
| lambda        | Provide your own lambda resource. Only required if `create_lambda` is set to `false`.                               | `any`                                                                                                                  | `null`  |    no    |
| tags          | Map of tags that will be added to created resources. By default resources will be tagged with name and environment. | `map(string)`                                                                                                          | `{}`    |    no    |

## Outputs

| Name    | Description |
| ------- | ----------- |
| gateway | n/a         |

## Requirements

| Name      | Version |
| --------- | ------- |
| terraform | ~> 0.12 |
| aws       | ~> 2.50 |

## Providers

| Name | Version |
| ---- | ------- |
| aws  | ~> 2.50 |

## Inputs

| Name          | Description                                                                                                         | Type                                                                                                                   | Default | Required |
| ------------- | ------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| environment   | Name of the environment will be used to name resources unique.                                                      | `string`                                                                                                               | n/a     |   yes    |
| create_lambda | Let the module create the lambda, provide the config for the lambda via `lambda_config`.                            | `bool`                                                                                                                 | `true`  |    no    |
| labmda_config | Configuration for the lambda. Only required if `create_lambda` is set to `true`.                                    | <pre>object({<br> filename = string<br> handler = string<br> runtime = string<br> variables = map(string)<br> })</pre> | `null`  |    no    |
| lambda        | Provide your own lambda resource. Only required if `create_lambda` is set to `false`.                               | `any`                                                                                                                  | `null`  |    no    |
| tags          | Map of tags that will be added to created resources. By default resources will be tagged with name and environment. | `map(string)`                                                                                                          | `{}`    |    no    |

## Outputs

| Name    | Description |
| ------- | ----------- |
| gateway | n/a         |

## Requirements

| Name      | Version |
| --------- | ------- |
| terraform | ~> 0.12 |
| aws       | ~> 2.50 |

## Providers

| Name | Version |
| ---- | ------- |
| aws  | ~> 2.50 |

## Inputs

| Name          | Description                                                                                                         | Type                                                                                                                   | Default | Required |
| ------------- | ------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| environment   | Name of the environment will be used to name resources unique.                                                      | `string`                                                                                                               | n/a     |   yes    |
| create_lambda | Let the module create the lambda, provide the config for the lambda via `lambda_config`.                            | `bool`                                                                                                                 | `true`  |    no    |
| labmda_config | Configuration for the lambda. Only required if `create_lambda` is set to `true`.                                    | <pre>object({<br> filename = string<br> handler = string<br> runtime = string<br> variables = map(string)<br> })</pre> | `null`  |    no    |
| lambda        | Provide your own lambda resource. Only required if `create_lambda` is set to `false`.                               | `any`                                                                                                                  | `null`  |    no    |
| tags          | Map of tags that will be added to created resources. By default resources will be tagged with name and environment. | `map(string)`                                                                                                          | `{}`    |    no    |

## Outputs

| Name    | Description |
| ------- | ----------- |
| gateway | n/a         |
