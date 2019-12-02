provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    encrypt = true
    acl     = "private"
    region  = "us-west-2"
  }
}
