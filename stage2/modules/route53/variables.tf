variable "prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "zone_id" {
  description = "Route53 zone ID"
  type        = string
}

variable "domain_name" {
  description = "Root domain name"
  type        = string
}

variable "cloudfront_domain_name" {
  description = "Domain name of the CloudFront distribution"
  type        = string
}

variable "cloudfront_hosted_zone_id" {
  description = "Hosted zone ID of the CloudFront distribution"
  type        = string
}

variable "subdomain" {
  description = "Subdomain for the CloudFront distribution"
  type        = string
}