variable "name" {
  type        = string
  description = "Name for the project"
}

variable "aws_region" {
  type        = string
  description = "AWS region in which to place the s3 bucket"
}

variable "domain" {
  type        = string
  description = "Domain at which the site will be served"
}

variable "environment" {
  type        = string
  description = <<EOT
    Optional environment, this determines the subdomain at which the site will be served and a name suffix for each of the resources generated.
    If an environment is not provided the site will be served at the root domain and the github actions environment will be production.
  EOT
  default     = null
  nullable    = true
}

variable "page_rule_priority" {
  type        = number
  description = <<EOT
    Cloudflare page rule priority.
    This needs to be distinct for each site in the cloudflare account to stop terraform always detecting no-op changes.
  EOT
}

locals {
  name        = "${var.name}${var.environment == null ? "-production" : "-${var.environment}"}"
  full_domain = var.environment == null ? var.domain : "${var.environment}.${var.domain}"
}
