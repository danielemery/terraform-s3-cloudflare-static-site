data "github_repository" "repo" {
  full_name = var.github_repository
}

resource "github_actions_environment_variable" "deployment_environment_variables" {
  repository      = data.github_repository.repo.name
  environment     = var.environment == null ? "production" : var.environment
  variable_name     = each.key
  value = each.value

  for_each = {
    AWS_REGION            = var.aws_region
    AWS_BUCKET_NAME       = module.static_site.s3_bucket_name
  }
}

resource "github_actions_environment_secret" "deployment_encrypted_secrets" {
  repository      = data.github_repository.repo.name
  environment     = var.environment == null ? "production" : var.environment
  secret_name     = each.key
  plaintext_value = each.value

  for_each = {
    AWS_ACCESS_KEY_ID     = module.static_site.s3_bucket_deploy_key_id
    AWS_SECRET_ACCESS_KEY = module.static_site.s3_bucket_deploy_key_id_secret
  }
}
