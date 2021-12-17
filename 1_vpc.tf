# Transit VPC
resource "aviatrix_vpc" "aws_transit_vpc" {
  for_each             = var.aws_vpc.transit_vpc
  cloud_type           = 1
  account_name         = var.aws_vpc_account_name
  region               = var.aws_vpc_region
  name                 = each.key
  cidr                 = each.value
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = true
}

# Spoke / Landing VPCs
resource "aviatrix_vpc" "aws_spoke_vpc" {
  for_each             = var.aws_vpc.spoke_vpc
  cloud_type           = 1
  account_name         = var.aws_vpc_account_name
  region               = var.aws_vpc_region
  name                 = each.key
  cidr                 = each.value
  subnet_size          = var.aws_subnet_size
  num_of_subnet_pairs  = var.aws_num_of_subnet_pairs
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
}

# Customer VPCs
resource "aviatrix_vpc" "aws_customer_vpc" {
  for_each             = var.aws_vpc.customer_vpc
  cloud_type           = 1
  account_name         = var.aws_vpc_account_name
  region               = var.aws_vpc_region
  name                 = each.key
  cidr                 = each.value
  subnet_size          = var.aws_subnet_size
  num_of_subnet_pairs  = var.aws_num_of_subnet_pairs
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
}

# On-prem VPC
resource "aviatrix_vpc" "aws_onprem_vpc" {
  for_each             = var.aws_vpc.onprem_vpc
  cloud_type           = 1
  account_name         = var.aws_vpc_account_name
  region               = var.aws_vpc_region
  name                 = each.key
  cidr                 = each.value
  subnet_size          = var.aws_subnet_size
  num_of_subnet_pairs  = var.aws_num_of_subnet_pairs
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
}