provider "aws" {
    region = var.region
}

resource "aws_security_group" "aws-ubuntu-sg" {
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        self = true
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port = var.ssh_custom_port
        to_port = var.ssh_custom_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 0
        to_port = 0
        protocol = "-1"
    }
}

resource "aws_instance" "aws-ubuntu-worker" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_pair_name
    count = 1
    tags = var.instance_tags
    security_groups = [aws_security_group.aws-ubuntu-sg.name]
}