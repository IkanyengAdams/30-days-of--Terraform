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