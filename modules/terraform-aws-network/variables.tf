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
  type        = list(map(string))
  default     = null
}

variable "egresses" {
  type        = list(map(string))
  default     = null
}