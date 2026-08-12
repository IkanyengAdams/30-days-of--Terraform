terraform {
    backend "s3" {
    bucket       = "techtutorialswithika-bucket-12345"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
    }
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


variable "environment" {
  default = "dev"
  type = string
}

variable "channel_name" {
  default = "techtutorialswithika"
}

variable "region" {
  default = "us-east-1"
}

locals {
  bucket_name = "${var.channel_name}-bucket-12345-${var.environment}-${var.region}"
  vpc_name = "${var.environment}-VPC"
}

# create s3 bucket
resource "aws_s3_bucket" "demo_bucket" { # internal name used for referencing in other files
  bucket = local.bucket_name # bucket name

  tags = {
    Name        = local.bucket_name
    Environment = var.environment
  }
}

resource "aws_vpc" "sample" {
  cidr_block = "10.0.1.0/24"
  region = var.region
  tags = {
    Environment = var.environment
    Name = local.vpc_name
  }
}

resource "aws_instance" "example" {
  ami = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  region = var.region

  tags = {
    Environment = var.environment
    Name = "${var.environment}-EC2-Instance"
  }
}

output "vpc_id" {  # prints out the output of a particular variable
  value = aws_vpc.sample.id
}

output "ec2_id" {
  value = aws_instance.example.id
}