variable "project_id" {}
variable "region" {
    default = "asia-southeast-1"
}
variable "zone" {
    default = "asia-southeast1-a"
}
variable "project_name" {
    default = "terraform-gcp"
}
variable "machine_type" {
    default = "f1-micro"
}
variable "image_family" {
    default = "centos-7"
}
variable "image_project" {
    default = "centos-cloud"
}
variable "disk_auto_delete" {
    default = true
}
variable "ssh_username" {}
variable "authentication_file" {
    default = "authentication.json"
}