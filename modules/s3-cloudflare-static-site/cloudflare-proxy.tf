data "cloudflare_zone" "website_zone" {
  name = var.domain
}

resource "cloudflare_record" "website_record" {
  zone_id = data.cloudflare_zone.website_zone.id
  name    = var.environment == null ? "@" : var.environment
  value   = aws_s3_bucket_website_configuration.website_bucket_configuration.website_endpoint
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_page_rule" "website_flexible_ssl" {
  zone_id  = data.cloudflare_zone.website_zone.id
  target   = "${local.full_domain}/*"
  priority = var.page_rule_priority

  actions {
    ssl = "flexible"
  }
}
