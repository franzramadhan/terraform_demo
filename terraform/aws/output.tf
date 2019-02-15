output "ec2_dns" {
    value = "${aws_instance.demo.public_dns}"
}

output "ec2_ip" {
    value = "${aws_instance.demo.public_ip}"
}