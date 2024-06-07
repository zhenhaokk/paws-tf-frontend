provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "pawsclaws-s3"
    key            = "global/s3/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "pawsclaws-terraform-lock"
    encrypt        = true
  }
}

module "s3" {
  source = "./modules/s3"
  bucket_name = var.bucket_name
  s3_bucket_id = module.s3.bucket_id
  prefix = var.prefix
}

module "cloudfront" {
  source = "./modules/cloudfront"

  subdomain            = var.subdomain
  domain_name          = var.domain_name
  s3_bucket_domain_name = module.s3.bucket_domain_name
  s3_bucket_id         = module.s3.bucket_id
  acm_certificate_arn  = module.acm.acm_certificate_arn
  zone_id = var.zone_id
}

module "route53" {
  source = "./modules/route53"
  prefix = var.prefix
  zone_id = var.zone_id
  domain_name = var.domain_name
  subdomain = var.subdomain
  cloudfront_domain_name = module.cloudfront.cloudfront_domain_name
  cloudfront_hosted_zone_id = module.cloudfront.cloudfront_hosted_zone_id
}

module "acm" {
  source = "./modules/acm"
  providers = {
    aws = aws.us-east-1
  }

  prefix      = var.prefix
  subdomain   = var.subdomain
  domain_name = var.domain_name
  zone_id     = var.zone_id
}