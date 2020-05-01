## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | Name of the environment will be used to name resources unique. | `string` | n/a | yes |
| create\_lambda | Let the module create the lambda, provide the config for the lambda via `lambda_config`. | `bool` | `true` | no |
| labmda\_config | Configuration for the lambda. Only required if `create_lambda` is set to `true`. | <pre>object({<br>    filename  = string<br>    handler   = string<br>    runtime   = string<br>    variables = map(string)<br>  })</pre> | `null` | no |
| lambda | Provide your own lambda resource. Only required if `create_lambda` is set to `false`. | `any` | `null` | no |
| tags | Map of tags that will be added to created resources. By default resources will be tagged with name and environment. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| gateway | n/a |

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12 |
| aws | ~> 2.50 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.50 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | Name of the environment will be used to name resources unique. | `string` | n/a | yes |
| create\_lambda | Let the module create the lambda, provide the config for the lambda via `lambda_config`. | `bool` | `true` | no |
| labmda\_config | Configuration for the lambda. Only required if `create_lambda` is set to `true`. | <pre>object({<br>    filename  = string<br>    handler   = string<br>    runtime   = string<br>    variables = map(string)<br>  })</pre> | `null` | no |
| lambda | Provide your own lambda resource. Only required if `create_lambda` is set to `false`. | `any` | `null` | no |
| tags | Map of tags that will be added to created resources. By default resources will be tagged with name and environment. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| gateway | n/a |

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12 |
| aws | ~> 2.50 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.50 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | Name of the environment will be used to name resources unique. | `string` | n/a | yes |
| create\_lambda | Let the module create the lambda, provide the config for the lambda via `lambda_config`. | `bool` | `true` | no |
| labmda\_config | Configuration for the lambda. Only required if `create_lambda` is set to `true`. | <pre>object({<br>    filename  = string<br>    handler   = string<br>    runtime   = string<br>    variables = map(string)<br>  })</pre> | `null` | no |
| lambda | Provide your own lambda resource. Only required if `create_lambda` is set to `false`. | `any` | `null` | no |
| tags | Map of tags that will be added to created resources. By default resources will be tagged with name and environment. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| gateway | n/a |

