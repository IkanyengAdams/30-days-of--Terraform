locals {
  bucket_name = "${var.channel_name}-bucket-12345-${var.environment}-${var.region}"
  vpc_name = "${var.environment}-VPC"
}