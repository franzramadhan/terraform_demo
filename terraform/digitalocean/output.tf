output "droplet_ip" {
    value = ["${digitalocean_droplet.demo.*.ipv4_address}"]
}

output "ssh_private_key" {
    value = "${tls_private_key.demo.private_key_pem}"
}