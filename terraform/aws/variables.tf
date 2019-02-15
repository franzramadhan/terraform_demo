variable "access_key" {}
variable "secret_key" {}
variable "region" {
    default = "ap-southeast-1"
}
variable "instance_type" {
    default = "t2.micro"
}
variable "project_name" {
    default = "terraform_aws"
}
variable "has_public_ip" {
    default = true
}
variable "ssh_private_key" {
    default = "~/.ssh/aws"
}
variable "ssh_public_key" {
    default = "~/.ssh/aws.pub"
}
variable "ssh_port" {
    default = "22"
}