output "name" {
    value = aws_security_group.ec2-sg.name
}

output "arn" {
  value = aws_security_group.ec2-sg.arn
}

output "ingress" {
  value = aws_security_group.ec2-sg.ingress
}

output "egress" {
  value = aws_security_group.ec2-sg.egress
}