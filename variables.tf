#AWS VPC variables
variable "aws_vpc_account_name" {}
variable "aws_vpc_region" {}

variable "aws_vpc" {}
variable "aws_subnet_size" {}
variable "aws_num_of_subnet_pairs" {}

variable "aws_transit_gw_name" {}
variable "aws_transit_gw_size" {}
variable "aws_transit_gw_asn" {}

variable "aws_spoke_gw_size" {}

variable "instance_type" {}
variable "key_name" {}
variable "instance_username" {}
variable "instance_password" {}

variable "ingress_description" {}
variable "ingress_from_port" {}
variable "ingress_to_port" {}
variable "ingress_protocol" {}
variable "ingress_cidr_blocks" {}