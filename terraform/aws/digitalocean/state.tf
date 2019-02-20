terraform {
  backend "s3" {
    bucket = "digitalocean-remote-state-testing"
    key    = "terraform.tfstate"
    region = "ap-southeast-1"
  }
}