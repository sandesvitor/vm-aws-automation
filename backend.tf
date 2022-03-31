terraform {
  backend "s3" {
    bucket = "infra-state-bucket-b477ff"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
