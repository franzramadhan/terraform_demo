resource "aws_s3_bucket" "remote_state" {
    bucket = "${var.provider}-remote-state-${var.env}"

    versioning {
        enabled = true
    }

    tags {
        Name = "${var.provider}-remote-state-${var.env}"
        Environment = "${var.env}"
    }

}