resource "aviatrix_spoke_gateway" "spoke_gw" {
  for_each                          = aviatrix_vpc.aws_spoke_vpc
  cloud_type                        = 1
  account_name                      = var.aws_vpc_account_name
  gw_name                           = each.key
  vpc_id                            = each.value.vpc_id
  vpc_reg                           = each.value.region
  gw_size                           = var.aws_spoke_gw_size
  subnet                            = each.value.public_subnets[0].cidr
  ha_gw_size                        = var.aws_spoke_gw_size
  ha_subnet                         = each.value.public_subnets[1].cidr
  single_ip_snat                    = false
  enable_active_mesh                = true
  manage_transit_gateway_attachment = false
  enable_auto_advertise_s2c_cidrs   = true

  depends_on = [
    aviatrix_vpc.aws_spoke_vpc
  ]
}

resource "aviatrix_spoke_transit_attachment" "spoke_transit_attach" {
  for_each        = aviatrix_spoke_gateway.spoke_gw
  spoke_gw_name   = each.value.gw_name
  transit_gw_name = aviatrix_transit_gateway.transit_gw[keys(var.aws_vpc.transit_vpc)[0]].gw_name
}