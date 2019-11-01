output "name" {
  value = format("\"%s\"", aws_cloudfront_distribution.website_cdn.domain_name)
}

output "zone" {
  value = format("\"%s\"", aws_cloudfront_distribution.website_cdn.hosted_zone_id)
}