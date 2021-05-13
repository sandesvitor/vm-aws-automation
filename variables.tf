variable  "region" {
  type        = string
  default     = "sa-east-1"
  description = "AWS instance region"
}

variable "vpc_name_tag" {
  type    = string
  default = "vpc_test" 
}

variable "subnet_name_tag" {
  type    = string
  default = "subnet_test" 
}

variable "internet_gateway_name_tag" {
  type    = string
  default = "internet_gateway_test" 
}


variable "route_table_name_tag" {
  type    = string
  default = "route_table_name_test" 
}

variable "main_network_block" {
  type = string
  default = "192.168.0.0/16"
}

variable "subnet_prefix_extension" {
  type = number
}

variable "ingresses" {
  type = list(
    object({
      from_port  = number
      to_port = number
      protocol = string
      cidr_blocks = list(string)
    })
  )
  default = [
      {
          from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
      }
  ]
}

variable "egresses" {
  type = list(
    object({
      from_port  = number
      to_port = number
      protocol = string
      cidr_blocks = list(string)
    })
  )
  default = [
      {
          from_port = 0,
          to_port = 0,
          protocol = "-1",
          cidr_blocks = ["0.0.0.0/0"],
      }
  ]
}

variable  "ec2_name_tag" {
  type        = string
  default     = "ec2_name"
}

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
