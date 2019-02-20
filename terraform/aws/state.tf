terraform {
  backend "s3" {
    bucket = "aws-remote-state-testing"
    key = "terraform.tfstate"
    region = "ap-southeast-1"
  }
}