provider "digitalocean" {
    token = "${var.do_token}"
}

# Get centos7 image
data "digitalocean_image" "centos7" {
    slug = "centos-7-x64"
}

# Generate RSA key
resource "tls_private_key" "demo" {
    algorithm = "RSA"
}

# Create ssh keypair
resource "digitalocean_ssh_key" "demo" {
    name = "${var.project_name}-key"
    public_key = "${tls_private_key.demo.public_key_openssh}"
}

resource "digitalocean_firewall" "demo" {
    name = "inbound-allow-ssh-only-outbound-all"

    droplet_ids = ["${digitalocean_droplet.demo.id}"]

    inbound_rule = [
        {
            protocol = "tcp"
            port_range = "22"
            source_addresses = ["0.0.0.0/0","::/0"]
        }
    ]

    outbound_rule = [
        {
            protocol = "tcp"
            port_range = "1-65535"
            destination_addresses = ["0.0.0.0/0","::/0"]
        },
        {
            protocol = "udp"
            port_range = "1-65535"
            destination_addresses = ["0.0.0.0/0","::/0"]
        },
        {
            protocol = "icmp"
            destination_addresses = ["0.0.0.0/0","::/0"]
        }
    ]

}

# Create a demo droplet
resource "digitalocean_droplet" "demo" {
    image  = "${data.digitalocean_image.centos7.image}"
    name   = "${var.project_name}-vm"
    region = "${var.region}"
    size   = "${var.size}"
    count = "${var.count}"
    private_networking = "${var.ip_private_enabled}"
    ssh_keys = ["${digitalocean_ssh_key.demo.fingerprint}"]
    tags = ["${var.project_name}-demo"]
}

# Create floating IP
resource "digitalocean_floating_ip" "demo" {
    droplet_id = "${digitalocean_droplet.demo.id}"
    region     = "${digitalocean_droplet.demo.region}"
}