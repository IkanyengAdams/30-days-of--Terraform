# Terraform Meta-Arguments

- Meta-arguments are special Terraform arguments that control how Terraform manages a resource, rather than defining the actual AWS resource itself.


- count

count tells Terraform:

"Create this resource multiple times."

Example:

resource "aws_s3_bucket" "example" {
  count  = 3
  bucket = "my-bucket-${count.index}"
}

Terraform creates:

my-bucket-0
my-bucket-1
my-bucket-2

The important part is:

count.index

count.index gives you the current numerical index.

So:

count.index = 0
count.index = 1
count.index = 2

When should you use count?

Use it when you simply need N copies of essentially the same resource.

For example:

count = 3

means:

"I need three of these."


- for_each

for_each also creates multiple resources, but instead of using numerical indexes, it uses keys.

Example:

resource "aws_s3_bucket" "example" {
  for_each = toset(["dev", "staging", "prod"])


  bucket = "my-app-${each.value}"
}

Terraform creates:

my-app-dev
my-app-staging
my-app-prod

Here we have:

each.key
each.value

For a set, they are effectively the same value.

For example:

each.value = "dev"

Why is for_each powerful?

Terraform addresses the resources using their keys:

aws_s3_bucket.example["dev"]
aws_s3_bucket.example["staging"]
aws_s3_bucket.example["prod"]

This is much more descriptive than:

aws_s3_bucket.example[0]
aws_s3_bucket.example[1]
aws_s3_bucket.example[2]


- Simple rule

count → use when you care about quantity.

for_each → use when you care about individual items.

In production Terraform, you'll often see for_each preferred when resources have meaningful identities.


- depends_on

Terraform normally figures out dependencies automatically.

For example:

resource "aws_s3_bucket" "primary" {
  bucket = "primary-bucket"
}


resource "aws_s3_bucket" "dependent" {
  bucket = "dependent-bucket"


  depends_on = [
    aws_s3_bucket.primary
  ]
}

This tells Terraform:

"Create primary before dependent."

So:

primary
   ↓
dependent


- lifecycle

lifecycle is extremely important because it controls what Terraform does when changing or destroying resources.

Example:

resource "aws_s3_bucket" "example" {
  bucket = "my-bucket"


  lifecycle {
    prevent_destroy = true
  }
}

There are three important lifecycle rules in today's lesson.

prevent_destroy
lifecycle {
  prevent_destroy = true
}

This tells Terraform:

"Do not allow this resource to be destroyed."

This is useful for critical resources.

- create_before_destroy
lifecycle {
  create_before_destroy = true
}

Normally, Terraform may do:

Destroy old
     ↓
Create new

That could cause downtime.

With:

create_before_destroy = true

Terraform tries to do:

Create new
     ↓
Destroy old

This can help reduce downtime when replacing resources.


- ignore_changes
lifecycle {
  ignore_changes = [tags]
}

This tells Terraform:

"If the tags change outside Terraform, don't try to change them back."

For example:

Terraform creates:

Environment = dev

Someone changes the tag manually in AWS.

Normally Terraform may detect:

Terraform configuration ≠ AWS

and attempt to correct it.

With:

ignore_changes = [tags]

Terraform ignores changes to those tags.

Important

Don't use ignore_changes just to hide configuration problems.

Use it when you intentionally allow something else to manage that attribute.


- provider

You normally have something like:

provider "aws" {
  region = "eu-west-1"
}

Terraform then uses that provider configuration.

But what if you want AWS in another region?

You can create an alias:

provider "aws" {
  region = "eu-west-1"
}


provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

Then a resource can explicitly use the second provider:

resource "aws_s3_bucket" "example" {
  provider = aws.west


  bucket = "my-bucket"
}

So:

provider = aws.west

means:

"Don't use the default AWS provider. Use the provider configuration called west."

Why is this useful?

Mainly for:

Multiple AWS regions
Multiple AWS accounts
Multi-region infrastructure

This is particularly useful when building larger AWS environments.


- for Expressions

This isn't technically a meta-argument, but today's lesson includes it because it's very useful for transforming data and creating outputs.

Suppose you have:

variable "names" {
  default = ["dev", "staging", "prod"]
}

You can transform it with:

[for name in var.names : upper(name)]

Result:

[
  "DEV",
  "STAGING",
  "PROD"
]

The basic structure is:

[for item in collection : expression]

Think:

"For every item in this collection, do something to it."