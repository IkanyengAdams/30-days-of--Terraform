output "vpc_id" {  # prints out the output of a particular variable
  value = aws_vpc.sample.id
}

output "ec2_id" {
  value = aws_instance.example.id
}