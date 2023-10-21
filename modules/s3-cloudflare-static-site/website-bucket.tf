# The s3 bucket to hold the static site, with a policy only allowing cloudflare ips to read it.
resource "aws_s3_bucket" "website_bucket" {
  bucket = local.full_domain
}

data "cloudflare_ip_ranges" "cloudflare" {}
resource "aws_s3_bucket_policy" "cloudflare_proxy_access" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "PublicReadGetObject",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:GetObject",
        "Resource" : "${aws_s3_bucket.website_bucket.arn}/*",
        "Condition" : {
          "IpAddress" : {
            "aws:SourceIp" : concat(data.cloudflare_ip_ranges.cloudflare.ipv4_cidr_blocks, data.cloudflare_ip_ranges.cloudflare.ipv6_cidr_blocks)
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "website_bucket_configuration" {
  bucket = aws_s3_bucket.website_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# The iam policy to allow cd to write to the s3 bucket
resource "aws_iam_policy" "cd_policy" {
  name        = "cd-deploy-${local.name}"
  description = "Role to allow cd jobs to publish bucket resources for ${local.name}"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "ListObjectsInBucket",
        "Effect" : "Allow",
        "Action" : [
          "s3:ListBucket"
        ],
        "Resource" : [
          "${aws_s3_bucket.website_bucket.arn}"
        ]
      },
      {
        "Sid" : "AllObjectActions",
        "Effect" : "Allow",
        "Action" : "s3:*Object",
        "Resource" : [
          "${aws_s3_bucket.website_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_user" "cd_user" {
  name = "github-actions-deploy-${local.name}"
}

resource "aws_iam_user_policy_attachment" "cd_user_policy" {
  user       = aws_iam_user.cd_user.name
  policy_arn = aws_iam_policy.cd_policy.arn
}

resource "aws_iam_access_key" "cd_user_key" {
  user = aws_iam_user.cd_user.name
}
