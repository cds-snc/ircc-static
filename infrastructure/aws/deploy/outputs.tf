output "name" {
  value = format("\"%s\"", aws_cloudfront_distribution.website_cdn.domain_name)
}

output "zone" {
  value = format("\"%s\"", aws_cloudfront_distribution.website_cdn.hosted_zone_id)
}

output "name_replacement" {
  value = format("\"%s\"", aws_cloudfront_distribution.website_cdn_replacement.domain_name)
}

output "zone_replacement" {
  value = format("\"%s\"", aws_cloudfront_distribution.website_cdn_replacement.hosted_zone_id)
}