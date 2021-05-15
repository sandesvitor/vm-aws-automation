data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ec2" {
  count     = length(data.aws_availability_zones.available.names)
  subnet_id = var.subnet_ids[count.index]

  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  security_groups = var.security_groups

  user_data = <<EOF
#!/bin/bash
echo "Hello, World!" > index.html
nohup busybox httpd -f -p 8080 &
EOF

  tags = {
    Name = "${var.ec2_name_tag}/${data.aws_availability_zones.available.names[count.index]}"
  }
}