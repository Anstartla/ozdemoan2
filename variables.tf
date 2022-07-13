variable "aws_region" {
  description = "The AWS region to deploy into"
  type        = string
}
variable "ec2_sg_id"{}
variable "prod_vpc_cidr_block"{
}
variable "devOps_vpc_cidr_block"{
}
variable "prefix_name"{
}
variable "tgw_id"{
}
variable "numbercheck_api_instances" {}
variable "ami_id" {
    description = "image id of os to be installed"
    type = string
}
variable "ami_id_apiserver" {
}
variable "min_size_apiserver" {
}
variable "max_size_apiserver" {
}
variable "instance_type_4_16" {
  description = "Instance type to use for EC2 Instance"
  type        = string
}
variable "disk_size" {
  description = "disk size for the root block device in GiB"
  type = number
}
variable "avail_zones" {
  description = "Availability Zones Used"
  type = list
}

variable "key_pair_name" {
  description = "The EC2 Key Pair to associate with the EC2 Instance for SSH access."
  type        = string
}
variable "key_pair_name_ec2" {}
variable "name_prefix" {
  description = "name for the resources to be created"
}
variable "target_ports_apiserver" {}
variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
