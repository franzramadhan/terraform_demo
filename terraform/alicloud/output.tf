output "ecs_public_ip" {
    value = "${alicloud_instance.demo.public_ip}"
}

output "ecs_private_ip" {
    value = "${alicloud_instance.demo.private_ip}"
}