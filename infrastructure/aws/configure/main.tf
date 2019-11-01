provider "aws" {
  version = "~> 2.0"
  region  = "${var.region}"
  shared_credentials_file = "../credentials"
}

provider "aws" {
  alias  = "us"
  version = "~> 2.0"
  region  = "us-east-1"
  shared_credentials_file = "../credentials"
}

terraform {
  backend "s3" {}
}