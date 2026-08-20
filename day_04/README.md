# Terraform State & Remote Backend

Terraform needs to keep track of the infrastructure it manages.

That's what the state file is for.

When you create an S3 bucket with Terraform, Terraform needs to remember:

"I created this bucket, and these are its current details."

That information is stored in:

- terraform.tfstate


# Desired State vs Actual State

This is the foundation of Terraform.

You have your desired state:

- What you wrote in your Terraform configuration.

And you have the actual infrastructure:

- What actually exists in AWS.


# What Is the State File?

The state file is essentially Terraform's record of the infrastructure it manages.

It contains information such as:

- Resources Terraform manages
- Resource IDs
- Resource attributes
- Dependencies
- Provider information

It is stored as JSON.


# Why Shouldn't You Manually Edit State?

The course says:

Never edit the state file manually.

That's very important.

The state file has Terraform-specific information and relationships that Terraform manages.

If you manually change it incorrectly, you can confuse Terraform about what infrastructure exists.

Instead, Terraform provides commands for manipulating state when necessary, such as:

terraform state list
terraform state show
terraform state rm
terraform state mv

You'll become much more comfortable with these later.

For now, understand:

Let Terraform manage the state rather than manually editing the JSON.


# Why Move State to S3?

Initially, Terraform can store state locally:

your-project/
├── main.tf
└── terraform.tfstate

That's fine when you're learning by yourself.

But imagine you're working with a team.

Your teammate runs Terraform from their computer.

They need access to the same state.

You don't want:

Developer A → local state
Developer B → different local state
Developer C → another local state

Now everyone has a different understanding of the infrastructure.

Instead, you can store the state remotely.

For AWS, your course uses:

S3 as the remote backend.


# State Locking

This is another major concept from Day 4.

Imagine two people run Terraform at exactly the same time.

Developer A → terraform apply
Developer B → terraform apply

Both are trying to modify the same infrastructure and state.

That's dangerous.

Terraform therefore needs a way to say:

"Someone is currently modifying the state. Wait."

That's state locking.


# Why Enable S3 Versioning?

Your course recommends versioning on the state bucket.

Think of versioning as:

Keeping previous versions of the state object.

So instead of:

terraform.tfstate

being overwritten forever, S3 can retain previous versions.

That's useful if something goes wrong and you need to investigate or recover an earlier version.

# State Security

This is important because Terraform state can contain sensitive information depending on what resources and attributes you're managing.

Therefore:

Don't treat terraform.tfstate like an ordinary text file.

Your course recommends:

Encryption
Restricted IAM access
Versioning
Secure remote storage
Auditing/access logging

The key takeaway:

Protect your state file like sensitive infrastructure data.