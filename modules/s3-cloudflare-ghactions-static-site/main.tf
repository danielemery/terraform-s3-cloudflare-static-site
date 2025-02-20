terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.88.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
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
