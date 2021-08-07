/* terraform {
   backend = "remote"
   config = {
    encrypt        = true
    bucket         = “my-terraform-state"
    key            = "s3_bucket/terraform.tfstate"
    region         = "us-east-1e"
    dynamodb_table = "terraform-locks"
    }
}*/
provider "aws" {
  region     = "us-east-1e"
  access_key = "AKIAQGDZ3W2SB22QS7IZ"
  secret_key = "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"
 }

#Variable Declaration
variable "my-tf-test-bucket" {
  description = "AWS S3 bucket using terraform"
  type        = string
}

#Private Bucket w/ Tags
resource "aws_s3_bucket" "s3bucket" {
  bucket = var.my-tf-test-bucket
  acl    = "private"
  
  tags = {
    Name        = "my_bucket"
    Environment = "Dev"
  }
}

#Using versioning
resource "aws_s3_bucket" "s3bucket" {
  bucket = var.my-tf-test-bucket
  acl    = "private"

  versioning {
    enabled = true
  }
}

#Enable Logging
resource "aws_s3_bucket" "log_bucket" {
  bucket = "my-tf-log-bucket"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "s3bucket" {
  bucket = var.my-tf-test-bucket
  acl    = "private"

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }
}
