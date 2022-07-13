

provider "aws" {
  region = var.aws_region
}
terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "3.1.0"
    }
  }
}
provider "null" {
}

# --------------------------------------------------------------------------------------------------------------------
# TERRAFORM STATEFILE
# --------------------------------------------------------------------------------------------------------------------
terraform {
  backend "s3" {
 	encrypt = true
 	bucket = "ozsudemoan"
 	region = "ap-south-1"
 	key = "demosetup/terraform.tfstate"
    }
}
#-----------------------------
#VPC-PROD
#-----------------------------
module "vpc_prod" {
    source = "./modules/vpc_prod"
    prefix_name = var.prefix_name
    prod_vpc_cidr_block  = var.prod_vpc_cidr_block
    devOps_vpc_cidr_block = var.devOps_vpc_cidr_block
}


# --------------------------------------------------------------------------------------------------------------------
# VPC NETWORKING 
# --------------------------------------------------------------------------------------------------------------------
module "vpc_networking" {
    source = "./modules/vpc_networking"

    prefix_name             = var.name_prefix
    avail_zones             = var.avail_zones
    prod_vpc_id             = module.vpc_prod.prod_vpc_id
    devOps_vpc_id           = module.vpc_prod.prod_vpc_id
    prod_igw_id 	    = module.vpc_prod.prod_igw_id
    tgw_id                  = var.tgw_id
    ec2_sg_id               = var.ec2_sg_id
}

# ----------------------------------------------------------------------------------
# EC2 INSTANCE 
# ----------------------------------------------------------------------------------
module "ec2" {
  source = "./modules/ec2"

  name_prefix                     = var.name_prefix
  ami_id                          = var.ami_id
  prod_vpc_id                     = module.vpc_prod.prod_vpc_id
  instance_type_4_16              = var.instance_type_4_16 
  subnets                         = module.vpc_networking.private_subnet_id
  key_pair_name_ec2               = var.key_pair_name_ec2
  disk_size                       = var.disk_size

}


