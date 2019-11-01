resource "aws_s3_bucket_policy" "site_policy" {
  bucket = "${aws_s3_bucket.site.id}"
  policy = "${data.template_file.bucket_policy.rendered}"
}

data "template_file" "bucket_policy" {
  template = "${file("bucket_policy.json")}"
  vars = {
    origin_access_identity_arn = "${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"
    bucket = "${aws_s3_bucket.site.arn}"
  }
}
