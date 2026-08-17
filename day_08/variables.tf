variable "environment" {
  default = "dev"
  type = string
}


variable "region" {
  type = string
  default = "us-east-1"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type = number

}

variable "monitoring_enabled" {
  description = "Enable detailed monitoring for EC2 instances"
  type = bool
  default = true
}

variable "associate_public_ip_address" {
  description = "Associate public IP address with EC2 instances"
  type = bool
  default = true
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type = list(string)
  default = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]
}

variable "instance_vm_type" {
  description = "what type of instance to use"
  type = list(string)
  default = [ "t2.micro", "t3.micro", "t2.medium" ]
}

variable "allowed_region" {
  description = "List of allowed AWS regions"
  type = set(string)
  default = [ "us-west-2", "eu-west-1", "us-east-1" ]
}

variable "tags" {
  type = map(string)
  default = {
   Environment = "dev"
    Name = "dev-Instance"
    created_by = "terraform"

  }
  }

variable "ingress_values" {
  type = tuple([ number, string, number ])
  default = [ 443, "tcp", 443 ]
}

variable "config" {
  type = object({
    region = string,
    monitoring = bool,
    instance_count = number

  })
  default = {
    region = "us-east-1",
    monitoring = true,
    instance_count = 1
  }
}

variable "bucket_names" {
  description = "List of s3 bucket names to create"
  type = list(string)
  default = [ "my-unique-bucket-day08-1234567", "my-unique-bucket-day08-12347548" ]
}

variable "bucket_name_set" {
  description = "List of s3 bucket names to create"
  type = set(string)
  default = [ "my-unique-bucket-day08-12345644", "my-unique-bucket-day08-12347570" ]
}