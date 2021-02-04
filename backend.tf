terraform {
    backend "s3" {
        region = "us-east-2"
        bucket = "aws-ubuntu-bucket"
        encrypt = "true"
        key = "terraform.tfstate"
    }
}
