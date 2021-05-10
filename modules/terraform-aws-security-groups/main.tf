resource "aws_security_group" "ec2-sg" {
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        self = true
    }
    
    dynamic "ingress" {
        for_each = var.ingresses
        content {
            from_port = ingress.value["from_port"]
            to_port = ingress.value["to_port"]
            protocol = ingress.value["protocol"]
            cidr_blocks = ingress.value["cidr_blocks"]
        }
    }
    
    dynamic "egress" {
        for_each = var.egresses
        content {
            from_port = egress.value["from_port"]
            to_port = egress.value["to_port"]
            protocol = egress.value["protocol"]
            cidr_blocks = egress.value["cidr_blocks"]
        }
    }
}