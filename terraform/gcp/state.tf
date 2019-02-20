terraform {
  backend "s3" {
    bucket = "gcp-remote-state-testing"
    key    = "terraform.tfstate"
    region = "ap-southeast-1"
  }
}