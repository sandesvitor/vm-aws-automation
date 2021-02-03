variable  "region" {
  type        = string
  default     = "us-east-2"
  description = "AWS instance region"
}

variable  "ami" {
  type        = string
  description = "AMI of machine/Check with provider region for availability"
}

variable  "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Type of instance/affects billing (t2.micro is currently the only free isntance in AWS)"
}

variable  "key_pair_name" {
  type        = string
}

variable  "public_key" {
  type        = string
}

variable "instance_tags" {
  type        = object({
      Name = string
      Type = string
  })
  description = "Tags for later Ansible jobs"
}


variable  "ingress_ssh_port" {
  type        = number
  default     = 22
}
