provider "google" {
  credentials = "${file("${path.module}/${var.authentication_file}")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}

# Generate SSH key
resource "tls_private_key" "compute_key" {
  algorithm = "RSA"
}

# Terraform plugin to generate random ID
resource "random_id" "instance_id" {
 byte_length = 8
}

# Single google cloud compute instance
resource "google_compute_instance" "demo" {
    name = "${format("%s-%s", var.project_name, random_id.instance_id.hex )}"
    machine_type = "${var.machine_type}"
    zone = "${var.zone}"
    
    boot_disk {
        initialize_params {
            image = "${format("%s/%s", var.image_project, var.image_family)}"
        }
        auto_delete = "${var.disk_auto_delete}"
    }

    # make sure docker and epel repository is installed
    # metadata_startup_script = "sudo yum -y update; sudo yum -y install epel-release; sudo yum install -y yum-utils device-mapper-persistent-data lvm2;sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo;sudo yum install -y docker-ce docker-ce-cli containerd.io; sudo systemctl start docker; sudo systemctl enable docker"
    metadata {
      sshKeys = "${var.ssh_username}:${tls_private_key.compute_key.public_key_openssh}"
    }

    # set to get ephemeral public ip
    network_interface {
        network = "default"
        access_config { }
    }
}

