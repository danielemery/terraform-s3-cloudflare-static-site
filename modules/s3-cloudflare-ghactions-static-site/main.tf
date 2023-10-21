terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

module "static_site" {
  source = "../s3-cloudflare-static-site"

  name              = var.name
  aws_region        = var.aws_region
  domain            = var.domain
  environment       = var.environment
  page_rule_priority = 1
}
