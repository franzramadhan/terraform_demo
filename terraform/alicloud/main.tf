provider "alicloud" {
    access_key = "${var.alicloud_access_key}"
    secret_key = "${var.alicloud_secret_key}"
    region = "${var.region}"
}

# Get centos image id
data "alicloud_images" "centos" {
    name_regex  = "^centos"
    most_recent = true
    owners      = "system"
}

# Create VPC
resource "alicloud_vpc" "demo" {
    name = "${var.project_name}-vpc"
    cidr_block = "192.168.100.0/24"
}

# Create vSwitch
resource "alicloud_vswitch" "demo" {
  vpc_id            = "${alicloud_vpc.demo.id}"
  cidr_block        = "192.168.100.0/25"
  availability_zone = "ap-southeast-5a"
}

# Create security group
resource "alicloud_security_group" "demo" {
    name = "${var.project_name}-sg"
    vpc_id = "${alicloud_vpc.demo.id}"
}

resource "alicloud_security_group_rule" "allow_ssh" {
    type = "ingress"
    ip_protocol = "tcp"
    port_range = "22/22"
    policy = "accept"
    priority = 1    
    security_group_id = "${alicloud_security_group.demo.id}"
    cidr_ip = "0.0.0.0/0"
}

# Create ssh keypair
resource "alicloud_key_pair" "demo" {
    key_name = "${var.project_name}-keypair"
    public_key = "${file("${var.ssh_public_key}")}"
}

resource "alicloud_instance" "demo" {
    internet_max_bandwidth_out = 10
    internet_charge_type = "${var.internet_charge_type}"
    security_groups = ["${alicloud_security_group.demo.*.id}"]
    vswitch_id = "${alicloud_vswitch.demo.id}"

    instance_type = "${var.instance_type}"
    instance_charge_type = "PostPaid"
    system_disk_category = "${var.system_disk_category}"
    image_id = "${data.alicloud_images.centos.images.0.id}"
    instance_name = "${var.project_name}-ecs"
    key_name = "${alicloud_key_pair.demo.id}"


    tags {
        Name = "${var.project_name}-demo",
        Role = "${var.project_name}-ecs"
    }

    // connection {
    //     # Use default official Centos AMI username to login
    //     user = "root"
    //     type = "ssh"
    //     private_key = "${file("${var.ssh_private_key}")}"
    // }
    
    // # Make sure docker is installed and running
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
}