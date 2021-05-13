output "public_ips" {
    value = values(aws_instance.ec2)[*].public_ip
}

output "state" {
    value = values(aws_instance.ec2)[*].instance_state
}

output "id" {
    value = values(aws_instance.ec2)[*].id
}