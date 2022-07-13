# ------------------------------------------------------------------------
# VPC
# ------------------------------------------------------------------------
resource "aws_vpc" "prod_vpc" {
  cidr_block       = var.prod_vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.prefix_name}-production-vpc"
  }
}
# ------------------------------------------------------------------------
# VPC
# ------------------------------------------------------------------------
resource "aws_vpc" "devOps_vpc" {
  cidr_block       = var.devOps_vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.prefix_name}-devops-vpc"
  }
}



# ------------------------------------------------------------------------
# INTERNET GATEWAY
# ------------------------------------------------------------------------

resource "aws_internet_gateway" "prod_igw" {
  vpc_id = aws_vpc.prod_vpc.id
  tags = {
    Name = "${var.prefix_name}-production-igw"
  }
}
#------------------------------------------------------------------------
# VPC PEERING
# ------------------------------------------------------------------------
resource "aws_vpc_peering_connection" "prod_to_devOps" {
  peer_vpc_id   = aws_vpc.prod_vpc.id
  vpc_id        = aws_vpc.devOps_vpc.id
  auto_accept   = true
  accepter {
    allow_remote_vpc_dns_resolution = true
  }

   requester {
     allow_remote_vpc_dns_resolution = true
   }
   tags = {
     "Name" = "${var.prefix_name}-prod-to-devops"
   }
 }
