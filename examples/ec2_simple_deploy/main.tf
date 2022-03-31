##########################################################################
############################ VARIABLES ###################################

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Type of instance/affects billing (t2.micro is currently the only free isntance in AWS)"
}

variable "region" {
  type        = string
  default     = "sa-east-1"
  description = "AWS instance region"
}

variable "ec2_name_tag" {
  type    = string
  default = "ec2_name"
}


##########################################################################
############################ MAIN MODULE #################################

terraform {
  required_version = ">= 0.13"
}

provider "aws" {
  region = var.region
}

module "network" {
  source                  = "../../modules/terraform-aws-network"
  main_network_block      = "192.168.0.0/16"
  subnet_prefix_extension = 4
  ingresses = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "ec2" {
  source = "../../modules/terraform-aws-ec2"

  ec2_name_tag  = var.ec2_name_tag
  instance_type = var.instance_type
  subnet_ids    = module.network.public_subnets_id
  user_Data     = <<EOF
    #!/bin/bash
    echo "Hello, World!" > index.html
    nohup busybox httpd -f -p 8080 &
EOF
}


##########################################################################
############################ OUTPUTS #####################################

output "public_ips" {
  value = module.ec2.public_ips
}

output "state" {
  value = module.ec2.state
}

output "id" {
  value = module.ec2.id
}