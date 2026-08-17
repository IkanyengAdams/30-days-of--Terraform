resource "aws_instance" "example" {
  ami = "ami-0bdc7d025135d7b49" # Amazon Linux 2 AMI
  instance_type = var.instance_vm_type[0]
  region = var.region

  tags = var.tags

  lifecycle {
    create_before_destroy = true
    # prevent_destroy = true
  }
}


