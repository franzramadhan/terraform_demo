output "digitalocean_droplet_ip" {
    value = ["${digitalocean_droplet.demo.*.ipv4_address}"]
}

output "digitalocean_ssh_private_key" {
    value = "${tls_private_key.demo.private_key_pem}"
}

output "digitalocean_droplet_floating_ip" {
    value = "${digitalocean_floating_ip.demo.ip_address}"
}