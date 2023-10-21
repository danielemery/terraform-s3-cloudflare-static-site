# S3/Cloudflare Static Site

Opinionated terraform modules for creating static sites on AWS S3, with Cloudflare DNS & proxy.

## Infrastructure modules

Includes the main module:

- `s3-cloudflare-static-site`

And convenience wrappers:

- `s3-cloudflare-ghactions-static-site` (also adds required secrets to Github for use by actions)

## Coming Soon: Secrets modules

Includes modules for creating the minimal secrets required for the above modules.
