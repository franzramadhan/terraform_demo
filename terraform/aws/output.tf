output "aws_ec2_dns" {
    value = "${aws_instance.demo.public_dns}"
}

output "aws_ec2_ip" {
    value = "${aws_instance.demo.public_ip}"
}