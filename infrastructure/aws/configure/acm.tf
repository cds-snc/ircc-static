resource "aws_acm_certificate" "cert" {
  provider = aws.us
  domain_name = "*.${var.domain}"
  subject_alternative_names = [
    "${var.domain}"
  ]
  validation_method = "DNS"
}

resource "aws_acm_certificate" "cert_replacement" {
  provider = aws.us
  domain_name = "*.rescheduler.cds-snc.ca"
  subject_alternative_names = [
    "rescheduler.cds-snc.ca"
  ]
  validation_method = "DNS"
}