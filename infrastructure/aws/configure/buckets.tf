resource "aws_s3_bucket" "logs" {
  bucket = "${var.name}-site-logs"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "site" {
  bucket = "${var.name}-site-bucket"

  logging {
    target_bucket = "${aws_s3_bucket.logs.bucket}"
    target_prefix = "${var.name}/"
  }

  website {
    index_document = "index.html"
  }
}