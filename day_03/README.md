# Terraform Needs Permission to Talk to AWS

Authentication = Who are you?

Authorization = What are you allowed to do?

# How Terraform Gets AWS Credentials

There are several ways Terraform can obtain AWS credentials.

AWS CLI

You can configure credentials using:

- aws configure


# S3

S3 stands for:

Simple Storage Service

It's AWS's object storage service.

You store objects such as:

Files
Images
Backups
Logs
Data

inside S3 buckets.

Think of it simply as:

AWS
└── S3
    └── Bucket
        ├── file1
        ├── image.jpg
        └── backup.zip

The bucket is the container that holds your objects.

- tf show command => let's you inspect Terraform's current recorded info about your infra