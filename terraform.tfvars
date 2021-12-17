# AWS VPC Variables
aws_vpc_account_name = "AWS-BW"
aws_vpc_region       = "us-east-1"

# VPC Name | CIDR
aws_vpc = {
  transit_vpc = {
    "Transit" = "172.16.254.0/23"
  }
  spoke_vpc = {
    "LandingCustomerA" = "172.16.1.0/24",
    "LandingCustomerB" = "172.16.2.0/24"
  }
  onprem_vpc = {
    "OnPremDC" = "192.16.168.0/24"
  }
  customer_vpc = {
    "CustomerA" = "10.0.0.0/24",
    "CustomerB" = "10.0.0.0/24"
  }
}

aws_subnet_size         = "28"
aws_num_of_subnet_pairs = "2"

#Transit Gateway
aws_transit_gw_name = "cloud-transit"
aws_transit_gw_size = "t2.micro"
aws_transit_gw_asn  = "65501"

#Spoke Gateways
aws_spoke_gw_size = "t2.micro"

# EC2 variables
instance_type = "t2.micro"
key_name      = "vm_keypair"

instance_username = "ubuntu"
instance_password = "Aviatrix123"

ingress_description = "Allow Any Ingress"
ingress_from_port   = 0
ingress_to_port     = 0
ingress_protocol    = "-1"
ingress_cidr_blocks = "0.0.0.0/0"