resource "aws_instance" "aws-ubuntu-worker" {
    ami = var.ami
    instance_type = var.instance_type
    security_groups = var.security_groups
}