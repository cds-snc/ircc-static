output "bucket" {
  value = format("\"%s\"", aws_s3_bucket.storage_bucket.id)
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