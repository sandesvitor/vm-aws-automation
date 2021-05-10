resource "aws_instance" "aws-ubuntu-worker" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_pair_name
    security_groups = [var.security_groups]
}