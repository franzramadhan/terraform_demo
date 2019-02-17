output "alicloud_ecs_public_ip" {
    value = "${alicloud_instance.demo.public_ip}"
}

output "alicloud_ecs_private_ip" {
    value = "${alicloud_instance.demo.private_ip}"
}