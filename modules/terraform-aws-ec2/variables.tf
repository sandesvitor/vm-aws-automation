variable "ec2_name_tag" {
  type    = string
  default = "ec2_name"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Type of instance/affects billing (t2.micro is currently the only free isntance in AWS)"
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_groups" {
  type    = list(string)
  default = []
}

variable "user_data" {
  type    = string
  default = null
}