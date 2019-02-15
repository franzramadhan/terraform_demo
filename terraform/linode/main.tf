provider "linode" {
    token = "${var.token}"
}

# Generate SSH keypair
resource "tls_private_key" "linode" {
    algorithm = "RSA"
}

resource "linode_instance" "demo" {
    label = "${var.project_name}-test"
    image = "${var.linode_os}"
    group = "${var.group}"
    region = "${var.region}"
    type = "${var.type}"
    authorized_keys = [ "${chomp(tls_private_key.linode.public_key_openssh)}" ]
    root_pass = "${var.root_pass}"
    tags = ["terraform_linode","demo"]
    swap_size = "${var.swap_size}"
    private_ip = true
}