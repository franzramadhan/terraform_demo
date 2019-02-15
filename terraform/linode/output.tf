output "linode_public_ip" {
    value = "${linode_instance.demo.ip_address}"
}

output "linode_private_ip" {
    value = "${linode_instance.demo.private_ip_address}"
}

output "linode_ssh_private_key" {
    value = "${tls_private_key.linode.private_key_pem}"
}