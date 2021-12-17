# Learn my public IP
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

module "spoke_private_ec2" {
  for_each = var.aws_vpc.spoke_vpc
  source   = "github.com/bayupw/aws-ubuntu-wpassword"

  vpc_name   = each.key
  vpc_subnet = "${each.key}-Private-1-*"

  instance_type     = var.instance_type
  key_name          = var.key_name
  instance_name     = "${each.key}-private-vm"
  instance_username = var.instance_username
  instance_password = var.instance_password

  ingress_description = var.ingress_description
  ingress_from_port   = var.ingress_from_port
  ingress_to_port     = var.ingress_to_port
  ingress_protocol    = var.ingress_protocol
  ingress_cidr_blocks = var.ingress_cidr_blocks

  associate_public_ip_address = false

  depends_on = [
    aviatrix_vpc.aws_spoke_vpc
  ]
}

module "onprem_private_ec2" {
  for_each = var.aws_vpc.onprem_vpc
  source   = "github.com/bayupw/aws-ubuntu-wpassword"

  vpc_name   = each.key
  vpc_subnet = "${each.key}-Private-1-*"

  instance_type     = var.instance_type
  key_name          = var.key_name
  instance_name     = "${each.key}-private-vm"
  instance_username = var.instance_username
  instance_password = var.instance_password

  ingress_description = var.ingress_description
  ingress_from_port   = var.ingress_from_port
  ingress_to_port     = var.ingress_to_port
  ingress_protocol    = var.ingress_protocol
  ingress_cidr_blocks = var.ingress_cidr_blocks

  associate_public_ip_address = false

  depends_on = [
    aviatrix_vpc.aws_spoke_vpc
  ]
}

module "customer_private_ec2" {
  for_each = var.aws_vpc.customer_vpc
  source   = "github.com/bayupw/aws-ubuntu-wpassword"

  vpc_name   = each.key
  vpc_subnet = "${each.key}-Private-1-*"

  instance_type     = var.instance_type
  key_name          = var.key_name
  instance_name     = "${each.key}-private-vm"
  instance_username = var.instance_username
  instance_password = var.instance_password

  ingress_description = var.ingress_description
  ingress_from_port   = var.ingress_from_port
  ingress_to_port     = var.ingress_to_port
  ingress_protocol    = var.ingress_protocol
  ingress_cidr_blocks = var.ingress_cidr_blocks

  associate_public_ip_address = false

  depends_on = [
    aviatrix_vpc.aws_spoke_vpc
  ]
}

#Public EC2
module "spoke_public_ec2" {
  for_each = var.aws_vpc.spoke_vpc
  source   = "github.com/bayupw/aws-ubuntu-wpassword"

  vpc_name   = each.key
  vpc_subnet = "${each.key}-Public-1-*"

  instance_type     = var.instance_type
  key_name          = var.key_name
  instance_name     = "${each.key}-public-vm"
  instance_username = var.instance_username
  instance_password = var.instance_password

  ingress_description = var.ingress_description
  ingress_from_port   = var.ingress_from_port
  ingress_to_port     = var.ingress_to_port
  ingress_protocol    = var.ingress_protocol
  ingress_cidr_blocks = "${chomp(data.http.myip.body)}/32"

  associate_public_ip_address = true

  depends_on = [
    aviatrix_vpc.aws_spoke_vpc
  ]
}

module "onprem_public_ec2" {
  for_each = var.aws_vpc.onprem_vpc
  source   = "github.com/bayupw/aws-ubuntu-wpassword"

  vpc_name   = each.key
  vpc_subnet = "${each.key}-Public-1-*"

  instance_type     = var.instance_type
  key_name          = var.key_name
  instance_name     = "${each.key}-public-vm"
  instance_username = var.instance_username
  instance_password = var.instance_password

  ingress_description = var.ingress_description
  ingress_from_port   = var.ingress_from_port
  ingress_to_port     = var.ingress_to_port
  ingress_protocol    = var.ingress_protocol
  ingress_cidr_blocks = "${chomp(data.http.myip.body)}/32"

  associate_public_ip_address = true

  depends_on = [
    aviatrix_vpc.aws_spoke_vpc
  ]
}

module "customer_public_ec2" {
  for_each = var.aws_vpc.customer_vpc
  source   = "github.com/bayupw/aws-ubuntu-wpassword"

  vpc_name   = each.key
  vpc_subnet = "${each.key}-Public-1-*"

  instance_type     = var.instance_type
  key_name          = var.key_name
  instance_name     = "${each.key}-public-vm"
  instance_username = var.instance_username
  instance_password = var.instance_password

  ingress_description = var.ingress_description
  ingress_from_port   = var.ingress_from_port
  ingress_to_port     = var.ingress_to_port
  ingress_protocol    = var.ingress_protocol
  ingress_cidr_blocks = "${chomp(data.http.myip.body)}/32"

  associate_public_ip_address = true

  depends_on = [
    aviatrix_vpc.aws_spoke_vpc
  ]
}