
output "apiserver_sg_id" {
  value = aws_security_group.apiserver_sg.id
}
output "public_subnet_id" {
  value = aws_subnet.prod_public_subnet.id
}
output "private_subnet_id" {
  value = aws_subnet.prod_private_subnet.id
}
