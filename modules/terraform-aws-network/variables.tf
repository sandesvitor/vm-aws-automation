variable "main_network_block" {
  type = string
}

variable "subnet_prefix_extension" {
  type = number
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

variable "ingresses" {
  type = list(
    object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    })
  )
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "egresses" {
  type = list(
    object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    })
  )
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}