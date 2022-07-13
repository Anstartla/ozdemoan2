aws_region = "ap-south-1"
prod_vpc_cidr_block = "177.0.0.0/16"
devOps_vpc_cidr_block = "178.0.0.0/16"
prefix_name = "vpcoz"
key_pair_name = "ozdemoan"
key_pair_name_ec2 = "ozdemoan"
instance_type_4_16 = "t2.micro"
instance_type_8_32 = "t2.micro"
disk_size = 200
tgw_id = "tgw-032ed63e63cfca925"
ec2_sg_id = "sg-0e6d29f0739d6c8c6"
min_size_apiserver = 1
max_size_apiserver = 4
apiserver_instances = 2
numbercheck_api_instances = 2
ami_id = "ami-068257025f72f470d"  
ami_id_apiserver = "ami-068257025f72f470d"
avail_zones = ["ap-south-1a","ap-south-1b", "ap-south-1c"]
target_ports_portals = 8080
target_ports_apiserver = 80
name_prefix = "ozdemoan"
tags = {
  Env = "prod"
}

