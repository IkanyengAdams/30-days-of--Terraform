# Type Constraints in Terraform

The Big Idea

Remember from Day 5:

variable "environment" {
  type = string
}

The type is a type constraint.

You're telling Terraform:

"environment must contain a string."

This helps Terraform catch incorrect input before it tries to create infrastructure.

For example:

variable "environment" {
  type = string
}

Then:

environment = "production"

✅ Valid.

But:

environment = 123

❌ Not what the variable expects.


# The Three Basic Types

These are the easiest ones.

- string

Text.

variable "region" {
  type = string
}


variable "environment" {
  type = string
}

Values:

region      = "eu-west-1"
environment = "production"

Think:

string = text

- number

Numbers.

variable "instance_count" {
  type = number
}

You could provide:

instance_count = 3

or:

instance_count = 3.5

Think:

number = numeric value

- bool

Boolean values:

true
false

Example:

variable "enable_monitoring" {
  type = bool
}

Then:

enable_monitoring = true

Think:

bool = yes/no or true/false

# Lists

A list is an ordered collection of values.

For example:

variable "availability_zones" {
  type = list(string)
}

You could provide:

availability_zones = [
  "eu-west-1a",
  "eu-west-1b",
  "eu-west-1c"
]

Notice:

list(string)

means:

A list where every element must be a string.

You could also have:

variable "ports" {
  type = list(number)
}

Then:

ports = [80, 443, 8080]
Why is it called a list?

Because order matters.

[80, 443, 8080]

is conceptually different from:

[443, 80, 8080]


# Sets

A set is also a collection, but the important difference is:

Sets contain unique values and don't care about ordering.

Example:

variable "allowed_ports" {
  type = set(number)
}

You could provide:

allowed_ports = [80, 443, 443]

The duplicate 443 isn't meaningful in a set.

Think:

- list → ordered collection
- set  → unique collection where order isn't important

This distinction becomes useful when the order of values doesn't matter but duplicates shouldn't exist.


# Maps

A map is a collection of key-value pairs.

Example:

variable "instance_types" {
  type = map(string)
}

You could provide:

instance_types = {
  dev        = "t3.micro"
  staging    = "t3.small"
  production = "t3.medium"
}

Think:

key          value
────────────────────
dev          t3.micro
staging      t3.small
production   t3.medium

You could then access a value using:

var.instance_types["production"]

which gives:

t3.medium

So:

Map = key → value


# Tuple

A tuple is an ordered collection where each position can have a specific type.

Example:

variable "server_info" {
  type = tuple([string, number, bool])
}

The value could be:

server_info = [
  "web-server",
  2,
  true
]

The positions mean:

Position 0 → string
Position 1 → number
Position 2 → bool

So:

["web-server", 2, true]

is valid.

But:

[2, "web-server", true]

doesn't match the expected structure.

Think:

Tuple = ordered data with a specific type for each position.


# Object

An object is probably one of the most useful complex types you'll encounter.

It lets you define a structure with named attributes and specific types.

For example:

variable "server_config" {
  type = object({
    name          = string
    instance_type = string
    count         = number
    monitoring    = bool
  })
}

Now Terraform expects something like:

server_config = {
  name          = "web-server"
  instance_type = "t3.micro"
  count         = 2
  monitoring    = true
}

Notice how each attribute has a defined type:

name          → string
instance_type → string
count         → number
monitoring    → bool

This is basically a structured data object.

Think:

Object = named fields with defined types.