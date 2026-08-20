terraform {
   backend "s3" {
    bucket       = "techtutorialswithika-bucket-12345"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
    }
}