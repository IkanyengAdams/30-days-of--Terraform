# What is IaC

- managing infrastructure using code instead of manually creating it.

With Terraform, you describe what you want in code, and Terraform handles communicating with AWS.

# IaC gives you:

- Consistency — same code can create the same - infrastructure.
- Automation — Terraform does the repetitive work.
- Version control — infrastructure code can live in Git.
- Repeatability — destroy and recreate environments when necessary.
- Scalability — the same approach works whether you're creating a few resources or many.
- Reduced human error — fewer manual clicks and configuration mistakes.


# What is Terraform?

- Terraform is an Infrastructure as Code tool. Take the infrastructure you describe in Terraform configuration and make the real infrastructure match it.

# Terraform → AWS Provider → AWS API → AWS

The provider is what allows Terraform to understand and interact with AWS resources.


# terraform init

Initializes your Terraform project.

# terraform validate

Checks whether your Terraform configuration is syntactically and structurally valid.

# terraform plan

This is your preview.

Terraform looks at your configuration and determines what changes it believes are necessary.

# terraform apply

Actually performs the changes.

# terraform destroy

Removes infrastructure that Terraform manages.