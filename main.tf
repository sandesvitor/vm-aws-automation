terraform {
  required_version = ">= 0.13"
}

provider "aws" {
  region = var.region
}

module "network" {
  source                  = "./modules/terraform-aws-network"
  main_network_block      = var.main_network_block
  subnet_prefix_extension = var.subnet_prefix_extension
}

module "ec2_instance" {
  source                  = "./modules/terraform-aws-ec2"
  instance_type           = var.instance_type
  subnet_ids              = module.network.public_subnets_id
}