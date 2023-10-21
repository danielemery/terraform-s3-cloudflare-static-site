output "s3_bucket_name" {
  value = aws_s3_bucket.website_bucket.bucket
  description = "The s3 bucket where static assets should be uploaded"
}

output "s3_bucket_deploy_key_id" {
  value = aws_iam_access_key.cd_user_key.id
  description = "IAM access key id for the user that can deploy to the s3 bucket"
}

output "s3_bucket_deploy_key_id_secret" {
  value = aws_iam_access_key.cd_user_key.secret
  description = "IAM access key secret for the user that can deploy to the s3 bucket"
}
