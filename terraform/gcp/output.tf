output "gcp_instance_public_ip" {
    value = "${google_compute_instance.demo.network_interface.0.access_config.0.nat_ip}"
}

output "gcp_ssh_private_key" {
    value = "${tls_private_key.compute_key.private_key_pem}"
}

output "gcp_ssh_username" {
    value = "${var.ssh_username}"
}