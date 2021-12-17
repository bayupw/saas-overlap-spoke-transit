resource "aviatrix_transit_gateway" "transit_gw" {
  for_each        = aviatrix_vpc.aws_transit_vpc
  cloud_type      = 1
  account_name    = var.aws_vpc_account_name
  gw_name         = each.key
  vpc_id          = each.value.vpc_id
  vpc_reg         = each.value.region
  gw_size         = var.aws_transit_gw_size
  subnet          = each.value.public_subnets[0].cidr
  ha_gw_size      = var.aws_transit_gw_size
  ha_subnet       = each.value.public_subnets[2].cidr
  local_as_number = var.aws_transit_gw_asn

  enable_active_mesh       = true
  enable_hybrid_connection = true
  connected_transit        = true

  depends_on = [
    aviatrix_vpc.aws_transit_vpc
  ]
}

/*
output "transit_gw_name" {
  value = { for transitgw in keys(var.aws_vpc.transit_vpc) : transitgw => aviatrix_transit_gateway.transit_gw[transitgw].gw_name }
}
*/