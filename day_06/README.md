# Notes or day 5

# Terraform Variables

Variables exist so you don't hardcode values everywhere.

# The Three Types of Variables

- Input variables
- Local variables
- Output variables

# Input Variables

Input variables allow you to provide values to your Terraform configuration.

Example:

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "staging"
}

You can then use it:

tags = {
  Environment = var.environment
}


.tfvars
environment = "production"

Terraform reads the value from the variable file.

Command line
terraform plan -var="environment=production"

You're explicitly telling Terraform:

"For this run, use production."

Environment variable
export TF_VAR_environment="development"

# Variable Precedence

This is one part of Day 5 worth remembering.

If the same variable receives values from multiple places, Terraform has rules for determining which value wins.

For the sources covered in your course, think:

Command line > tfvars > environment variables > default

For example:

Default:

staging

terraform.tfvars:

demo

Environment variable:

development

Command line:

production

The command-line value wins.


# Local Variables

Now we move to locals.

A local is an internal value that Terraform can calculate and reuse.

Example:

locals {
  common_tags = {
    Environment = var.environment
    Project     = "Terraform-Demo"
  }
}

You can then use:

tags = local.common_tags

Notice the difference:

var.environment

means:

Input variable.

While:

local.common_tags

means:

Local value.


# Output Variables

Outputs are the opposite direction.

After Terraform creates infrastructure, you might want Terraform to show you useful information.

For example:

output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.demo.bucket
}

After terraform apply, Terraform can show:

bucket_name = "my-terraform-bucket"

So:

An output exposes useful information from your Terraform configuration.

# Input vs Local vs Output


| Type           | Purpose                                  | Access             |
| -------------- | ---------------------------------------- | ------------------ |
| Input variable | Value supplied to Terraform              | `var.name`         |
| Local          | Internal/reusable/calculated value       | `local.name`       |
| Output         | Value Terraform exposes after deployment | `terraform output` |


# Notes for day 6

# Terraform File Structure

- Terraform doesn't care how you split your .tf files.

You could have:

main.tf

with 500 resources inside it, and Terraform can still understand it.

Or you could have:

vpc.tf
security.tf
compute.tf
database.tf
outputs.tf

Terraform can still understand it.

# What About Loading Order?

Your course mentions that Terraform loads files in lexicographical order (alphabetically).

For example:

backend.tf
compute.tf
database.tf
main.tf
outputs.tf
provider.tf
variables.tf

would be alphabetically ordered.

But here's the important part:

Don't design your Terraform configuration assuming one .tf file must execute before another simply because of its filename.

