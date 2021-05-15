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

module "security_group" {
  source    = "./modules/terraform-aws-security-groups"
  ingresses = var.ingresses
  egresses  = var.egresses
}

module "ec2_instance" {
  source          = "./modules/terraform-aws-instance"
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [module.security_group.name]
}