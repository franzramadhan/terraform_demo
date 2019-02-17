provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.region}"
}

# Generate SSH key
resource "tls_private_key" "demo" {
  algorithm = "RSA"
}

# Get Centos AMI ID
data "aws_ami" "centos" {
    owners = ["679593333241"] 
    most_recent = true

    filter {
        name   = "name"
        values = ["CentOS Linux 7 x86_64 HVM EBS *"]
    }

    filter {
        name   = "architecture"
        values = ["x86_64"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }
}

# Generate key pair
resource "aws_key_pair" "demo" {
    key_name = "${var.project_name}-demo"
    #public_key = "${file("${var.ssh_public_key}")}"
    public_key = "${tls_private_key.demo.public_key_openssh}"
}

# Allow ssh access
resource "aws_security_group" "demo" {
    name = "${var.project_name}-sg"

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = "${var.ssh_port}"
        to_port   = "${var.ssh_port}"
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "${var.project_name}-sg"
    }
}


# Single ec2 instance
resource "aws_instance" "demo" {
    ami = "${data.aws_ami.centos.id}"
    instance_type = "${var.instance_type}"
    associate_public_ip_address = "${var.has_public_ip}"
    key_name = "${aws_key_pair.demo.id}"

    vpc_security_group_ids = ["${aws_security_group.demo.id}"]
    
    // connection {
    //     # Use default official Centos AMI username to login
    //     user = "centos"
    //     private_key = "${file("${var.ssh_private_key}")}"
    // }
    
    # Make sure docker is installed and running
    // provisioner "remote-exec" {
    //     inline = [
    //         "sudo yum -y update",
    //         "sudo yum -y install epel-release",
    //         "sudo yum -y remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine",
    //         "sudo yum -y install yum-utils device-mapper-persistent-data lvm2",
    //         "sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo",
    //         "sudo yum -y install docker-ce docker-ce-cli containerd.io",
    //         "sudo systemctl start docker && sudo systemctl enable docker"
    //     ]
    // }

    tags {
        Name = "${var.project_name}-vm"
    }
}