output "public_ips" {
  value = aws_instance.ec2.*.public_ip
}

output "state" {
  value = aws_instance.ec2.*.instance_state
}

output "id" {
  value = aws_instance.ec2.*.id
}