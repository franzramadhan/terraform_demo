terraform {
  backend "s3" {
    bucket = "alicloud-remote-state-testing"
    key = "terraform.tfstate"
    region = "ap-southeast-1"
  }
}