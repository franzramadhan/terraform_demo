variable "do_token" {}
variable "project_name" {
    default = "terraform-digitalocean"
}
variable "region" {
    default = "sgp1"
}
variable "size" {
    default = "s-1vcpu-1gb"
}
variable "count" {
    default = 1
}
variable "ip_private_enabled" {
    default = true
}