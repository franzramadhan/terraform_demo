provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.region}"
}

module "remote_state_aws" {
    source = "../modules/create_backend"
    provider = "aws"
}

module "remote_state_alicloud" {
    source = "../modules/create_backend"
    provider = "alicloud"
}

module "remote_state_digitalocean" {
    source = "../modules/create_backend"
    provider = "digitalocean"
}

module "remote_state_gcp" {
    source = "../modules/create_backend"
    provider = "gcp"
}

module "remote_state_linode" {
    source = "../modules/create_backend"
    provider = "linode"
}