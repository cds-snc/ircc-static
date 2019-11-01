output "bucket" {
  value = format("\"%s\"", var.bucket)
}

output "key" {
  value = format("\"%s\"", "terraform.tfstate")
}

output "region" {
  value = format("\"%s\"", "ca-central-1")
}

output "shared_credentials_file" {
  value = format("\"%s\"", "../credentials")
}

output "name" {
  value = format("\"%s\"", var.name)
}

output "domain" {
  value = format("\"%s\"", var.domain)
}

output "dns-record-name" {
  value = format("\"%s\"", aws_acm_certificate.cert.domain_validation_options[0].resource_record_name)
}

output "dns-record-type" {
  value = format("\"%s\"", aws_acm_certificate.cert.domain_validation_options[0].resource_record_type)
}

output "dns-record-value" {
  value = format("\"%s\"", aws_acm_certificate.cert.domain_validation_options[0].resource_record_value)
}