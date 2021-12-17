resource "aviatrix_site2cloud" "custa_vgw_s2c" {
  vpc_id                     = aviatrix_vpc.aws_spoke_vpc[keys(var.aws_vpc.spoke_vpc)[0]].vpc_id
  connection_name            = "custa_vgw_s2c"
  connection_type            = "mapped"
  remote_gateway_type        = "aws"
  tunnel_type                = "route"
  primary_cloud_gateway_name = aviatrix_spoke_gateway.spoke_gw[keys(var.aws_vpc.spoke_vpc)[0]].gw_name
  remote_gateway_ip          = aws_vpn_connection.vgw_cgw_connection[0].tunnel1_address
  pre_shared_key             = aws_vpn_connection.vgw_cgw_connection[0].tunnel1_preshared_key

  ha_enabled               = true
  backup_gateway_name      = aviatrix_spoke_gateway.spoke_gw[keys(var.aws_vpc.spoke_vpc)[0]].ha_gw_name
  backup_remote_gateway_ip = aws_vpn_connection.vgw_cgw_connection[0].tunnel2_address
  backup_pre_shared_key    = aws_vpn_connection.vgw_cgw_connection[0].tunnel2_preshared_key

  custom_mapped         = false
  remote_subnet_cidr    = values(var.aws_vpc.customer_vpc)[0]
  remote_subnet_virtual = "100.64.1.0/24"
  local_subnet_cidr     = values(var.aws_vpc.onprem_vpc)[0]
  local_subnet_virtual  = values(var.aws_vpc.onprem_vpc)[0]

  forward_traffic_to_transit = true

  depends_on = [
    aws_vpn_connection.vgw_cgw_connection
  ]
}

resource "aviatrix_site2cloud" "custb_vgw_s2c" {
  vpc_id                     = aviatrix_vpc.aws_spoke_vpc[keys(var.aws_vpc.spoke_vpc)[1]].vpc_id
  connection_name            = "custb_vgw_s2c"
  connection_type            = "mapped"
  remote_gateway_type        = "aws"
  tunnel_type                = "route"
  primary_cloud_gateway_name = aviatrix_spoke_gateway.spoke_gw[keys(var.aws_vpc.spoke_vpc)[1]].gw_name
  remote_gateway_ip          = aws_vpn_connection.vgw_cgw_connection[1].tunnel1_address
  pre_shared_key             = aws_vpn_connection.vgw_cgw_connection[1].tunnel1_preshared_key

  ha_enabled               = true
  backup_gateway_name      = aviatrix_spoke_gateway.spoke_gw[keys(var.aws_vpc.spoke_vpc)[1]].ha_gw_name
  backup_remote_gateway_ip = aws_vpn_connection.vgw_cgw_connection[1].tunnel2_address
  backup_pre_shared_key    = aws_vpn_connection.vgw_cgw_connection[1].tunnel2_preshared_key

  custom_mapped         = false
  remote_subnet_cidr    = values(var.aws_vpc.customer_vpc)[1]
  remote_subnet_virtual = "100.64.2.0/24"
  local_subnet_cidr     = values(var.aws_vpc.onprem_vpc)[0]
  local_subnet_virtual  = values(var.aws_vpc.onprem_vpc)[0]

  forward_traffic_to_transit = true

  depends_on = [
    aws_vpn_connection.vgw_cgw_connection
  ]
}

# Transit s2c
resource "aviatrix_vgw_conn" "transit-detached-vgw" {
  conn_name        = "transit-detached-vgw"
  gw_name          = aviatrix_transit_gateway.transit_gw[keys(var.aws_vpc.transit_vpc)[0]].gw_name
  vpc_id           = aviatrix_vpc.aws_transit_vpc[keys(var.aws_vpc.transit_vpc)[0]].vpc_id
  bgp_vgw_id       = aws_vpn_gateway.detached_vgw.id
  bgp_vgw_account  = var.aws_vpc_account_name
  bgp_vgw_region   = var.aws_vpc_region
  bgp_local_as_num = var.aws_transit_gw_asn

  depends_on = [
    aviatrix_transit_gateway.transit_gw,
    aws_vpn_gateway.detached_vgw
  ]
}
