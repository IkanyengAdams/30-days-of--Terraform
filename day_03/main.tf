terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# create s3 bucket
resource "aws_s3_bucket" "demo_bucket" { # internal name used for referencing in other files
  bucket = "techtutorialswithika-bucket-12345" # bucket name

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}