data "aws_vpc" "prod_cidr_block" {
  id = var.prod_vpc_id
}
data "aws_vpc" "devOps_cidr_block" {
  id = var.devOps_vpc_id
}
#data "aws_internet_gateway" "prod_igw" {
#  filter {
#   name   = "attachment.vpc-id"
#    values = [var.prod_vpc_id]
#  }
#}

data "aws_internet_gateway" "prod_igw" {
  internet_gateway_id = var.prod_igw_id

}
resource "aws_eip" "prod_nat_eip" {
  vpc      = true
  tags = {
      "Name" = "${var.prefix_name}-prod-nat-eip"
    }
}
resource "aws_subnet" "prod_public_subnet" {
  availability_zone         = var.avail_zones[0]
  cidr_block                = cidrsubnet(data.aws_vpc.prod_cidr_block.cidr_block, 8, 12)
  vpc_id                    = var.prod_vpc_id

  tags = {
    "Name" = "${var.prefix_name}-prod-public"
  }
}
resource "aws_subnet" "prod_private_subnet" {
  availability_zone         = var.avail_zones[1]
  cidr_block                = cidrsubnet(data.aws_vpc.prod_cidr_block.cidr_block, 8, 13)
  vpc_id                    = var.prod_vpc_id

  tags = {
    "Name" = "${var.prefix_name}-prod-private"
  }
}
resource "aws_nat_gateway" "prod_nat_gateway" {
    allocation_id = aws_eip.prod_nat_eip.id
    subnet_id = aws_subnet.prod_public_subnet.id
    tags = {
      "Name" = "${var.prefix_name}-prod-nat-gw"
    }
}
resource "aws_route_table" "prod_public_rtb" {
  vpc_id                    = var.prod_vpc_id
  route {
    cidr_block              = "0.0.0.0/0"
    gateway_id              = data.aws_internet_gateway.prod_igw.internet_gateway_id
  }
  tags = {
    "Name" = "${var.prefix_name}-prod-public-rtb"
  }
}

resource "aws_route_table" "prod_private_rtb" {
  vpc_id                    = var.prod_vpc_id
  route {
    cidr_block              = "0.0.0.0/0"
    nat_gateway_id          = aws_nat_gateway.prod_nat_gateway.id
  }
  tags = {
    "Name" = "${var.prefix_name}-prod-private-rtb"
  }
}


resource "aws_route_table_association" "prod_public" {
  subnet_id                 = aws_subnet.prod_public_subnet.id
  route_table_id            = aws_route_table.prod_public_rtb.id
}
resource "aws_route_table_association" "prod_private" {
  subnet_id                 = aws_subnet.prod_private_subnet.id 
  route_table_id            = aws_route_table.prod_private_rtb.id
}
resource "aws_security_group" "apiserver_sg" {
  name                      = "${var.prefix_name}-prod-apiserver-sg"
  vpc_id                    = var.prod_vpc_id
  egress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    cidr_blocks             = ["0.0.0.0/0"]
  }
  ingress {
    cidr_blocks             = [data.aws_vpc.prod_cidr_block.cidr_block]
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
  }
  ingress {
    cidr_blocks             = [data.aws_vpc.devOps_cidr_block.cidr_block]
    from_port               = 22
    to_port                 = 22
    protocol                = "TCP"
  }
  tags = {
    Name                    = "${var.prefix_name}-prod-apiserver-sg"
  } 
}

