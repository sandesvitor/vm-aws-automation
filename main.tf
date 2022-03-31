terraform {
  required_version = ">= 0.13"
}

provider "aws" {
  region = "us-east-1"
}

module "network" {
  source                  = "./modules/terraform-aws-network"
  main_network_block      = "192.168.0.0/16"
  subnet_prefix_extension = 8

  # Default security group rules:
  ingresses = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  egresses = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "ec2_instance" {
  source        = "./modules/terraform-aws-ec2"
  instance_type = "t2.micro"
  subnet_ids    = module.network.public_subnets_id
}