provider "aws" {
    region = var.region
}

# resource "aws_key_pair" "aws-ubuntu-terraform" {
#     key_name = var.key_pair_name
#     public_key = var.public_key
# }

resource "aws_security_group" "aws-ubuntu-sg" {
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        self = true
    }

    ingress {
        from_port = var.ingress_ssh_port
        to_port = 22
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