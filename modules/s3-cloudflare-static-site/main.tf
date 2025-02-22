terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.84.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}
