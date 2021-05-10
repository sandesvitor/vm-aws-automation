variable  "ami" {
  type        = string
  description = "AMI of machine/Check with provider region for availability"
  default     = "05373777d08895384"
}

variable  "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Type of instance/affects billing (t2.micro is currently the only free isntance in AWS)"
}

variable "security_groups" {
  type        = list(string)
}