variable "access_key" {}
variable "secret_key" {}
variable "region" {
    default = "ap-southeast-5"
}
variable "instance_type" {
    default = "ecs.t5-lc1m1.small"
}
variable "system_disk_category" {
    default = "cloud_efficiency"
}
variable "internet_charge_type" {
    default = "PayByTraffic"
}
variable "project_name" {
    default = "terraform_alicloud"
}
variable "ssh_private_key" {
    default = "~/.ssh/alicloud"
}
variable "ssh_public_key" {
    default = "~/.ssh/alicloud.pub"
}