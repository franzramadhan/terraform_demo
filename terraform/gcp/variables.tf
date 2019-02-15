variable "project_id" {}
variable "region" {}
variable "project_name" {
    default = "terraform-gcp"
}
variable "machine_type" {
    default = "f1-micro"
}
variable "zone" {}
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