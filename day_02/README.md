# What is a Provider?

A provider is the translator between Terraform and an external platform/API.

# Terraform Core vs Provider

- Terraform Core = This is the actual Terraform program you install.

 - Provider = The provider is a plugin that Terraform uses to communicate with a specific service.


# Version Constraints

This is probably the main thing to understand from Day 2.

= 1.2.3

Means:

Only version 1.2.3

Very strict.

>= 1.2

Means:

1.2 or anything newer

For example:

1.2
1.3
2.0
3.0

could satisfy it.

<= 1.2

Means:

1.2 or anything older

~> 1.2

This is the one you should pay attention to.

It's called a pessimistic constraint.

For the course's example:

version = "~> 1.2"

the intention is essentially:

"Allow compatible updates within the 1.x series, but don't jump to 2.x."

So you can think:

1.2
1.3
1.4
1.x

but not:

2.0

Range
version = ">= 1.2, < 2.0"

Means:

Use version 1.2 or newer, but don't use 2.0 or newer.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}