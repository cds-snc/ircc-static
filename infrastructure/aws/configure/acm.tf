resource "aws_acm_certificate" "cert" {
  provider = aws.us
  domain_name = "*.${var.domain}"
  subject_alternative_names = [
    "${var.domain}"
  ]
  validation_method = "DNS"
}