variable "environment" {
  description = "Name of the environment will be used to name resources unique."
  type        = string
}

variable "tags" {
  description = "Map of tags that will be added to created resources. By default resources will be tagged with name and environment."
  type        = map(string)
  default     = {}
}

variable "lambda" {
  description = "Provide your own lambda resource. Only required if `create_lambda` is set to `false`."
  default     = null
}

variable "create_lambda" {
  description = "Let the module create the lambda, provide the config for the lambda via `lambda_config`."
  type        = bool
  default     = true
}

variable "labmda_config" {
  description = "Configuration for the lambda. Only required if `create_lambda` is set to `true`."
  type = object({
    filename  = string
    handler   = string
    runtime   = string
    variables = map(string)
  })
  default = null
}
