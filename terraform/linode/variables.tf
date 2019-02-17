variable "linode_token" {}
variable "root_pass" {}
variable "project_name" {
    default = "terraform_linode"
}
variable "linode_os" {
    description = "Linode image type"
    default = "linode/centos7"
}
variable "group" {
    default = "linode"
}
variable "region" {
    description = "Linode server region"
    default = "ap-south"
}
variable "type" {
    description = "Linode instance flavor type"
    default = "g6-nanode-1"
}
variable "swap_size" {
    default = 128
}
