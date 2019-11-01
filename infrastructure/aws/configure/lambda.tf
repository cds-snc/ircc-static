data "template_file" "function" {
  template = "${file("lambda_function.js")}"
}

data "archive_file" "apply_security_headers" {
    type        = "zip"
    output_path = "hsts.zip"
    source {
      filename = "index.js"
      content = "${data.template_file.function.rendered}"
    }
}

resource "aws_iam_role" "lambda_iam" {
  name = "lambda_iam"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com",
          "edgelambda.amazonaws.com"
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = "${aws_iam_role.lambda_iam.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stm1",
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Sid": "Stm2",
      "Effect": "Allow",
      "Action": [
        "lambda:GetFunction"
      ],
      "Resource": "${aws_lambda_function.apply_security_headers.arn}:*"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "s3_policy" {
  name        = "s3_policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObjectAcl",
        "s3:GetObject",
        "s3:ListBucket",
        "s3:DeleteObject",
        "s3:PutObjectAcl"
      ],
      "Resource": [
        "${aws_s3_bucket.site.arn}/",
        "${aws_s3_bucket.site.arn}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_policy_s3_policy_attachment" {
    role       = "${aws_iam_role.lambda_iam.name}"
    policy_arn = "${aws_iam_policy.s3_policy.arn}"
}

resource "aws_lambda_function" "apply_security_headers" {
  provider         = "aws.us"
  filename         = "hsts.zip"
  function_name    = "apply_security_headers"
  role             = "${aws_iam_role.lambda_iam.arn}"
  handler          = "index.handler"
  source_code_hash = "${data.archive_file.apply_security_headers.output_base64sha256}"
  runtime          = "nodejs8.10"
  publish          = true
}

resource "aws_lambda_permission" "lambda_permssion_apply_security_headers_edgelambda" {
  provider      = "aws.us"
  statement_id  = "AllowExecutionFromCloudFront"
  action        = "lambda:GetFunction"
  function_name = "${aws_lambda_function.apply_security_headers.arn}"
  principal     = "edgelambda.amazonaws.com"
}

resource "aws_lambda_permission" "lambda_permssion_apply_security_headers_lambda" {
  provider      = "aws.us"
  statement_id  = "AllowExecutionFromCloudFront2"
  action        = "lambda:GetFunction"
  function_name = "${aws_lambda_function.apply_security_headers.arn}"
  principal     = "lambda.amazonaws.com"
}