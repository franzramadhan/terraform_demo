terraform {
  backend "s3" {
    bucket = "linode-remote-state-testing"
    key    = "terraform.tfstate"
    region = "ap-southeast-1"
  }
}