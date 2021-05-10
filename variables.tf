variable  "region" {
  type        = string
  default     = "us-east-2"
  description = "AWS instance region"
}

variable "main_network_block" {
  type = string
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

variable  "ami" {
  type        = string
  description = "AMI of machine/Check with provider region for availability"
  default     = "05373777d08895384"
}