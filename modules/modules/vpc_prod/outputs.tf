output "prod_vpc_id" {
  value = aws_vpc.prod_vpc.id
}
output "devOps_vpc_id" {
  value = aws_vpc.devOps_vpc.id
}
output "prod_igw_id" {
  value = aws_internet_gateway.prod_igw.id
}

