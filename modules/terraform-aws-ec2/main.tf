resource "aws_instance" "ec2" {
    for_each = toset(var.subnet_ids)
    subnet_id   = each.key

    ami             = var.ami
    instance_type   = var.instance_type
    security_groups = var.security_groups

    user_data = <<EOF
#!/bin/bash
echo "Hello, World!" > index.html
nohup busybox httpd -f -p 8080 &
EOF

    tags = {
    Name = "${var.ec2_name_tag}/${each.key}"
  }
}