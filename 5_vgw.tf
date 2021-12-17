resource "aws_vpn_gateway" "customer_vgw" {
  for_each = aviatrix_vpc.aws_customer_vpc
  vpc_id   = aviatrix_vpc.aws_customer_vpc[each.key].vpc_id

  tags = {
    Name = "vgw-${each.key}"
  }

  depends_on = [
    aviatrix_vpc.aws_customer_vpc
  ]
}


resource "aws_vpn_gateway_attachment" "vgw_attachment" {
  for_each       = aviatrix_vpc.aws_customer_vpc
  vpc_id         = aviatrix_vpc.aws_customer_vpc[each.key].vpc_id
  vpn_gateway_id = aws_vpn_gateway.customer_vgw[each.key].id

  depends_on = [
    aviatrix_vpc.aws_customer_vpc,
    aws_vpn_gateway.customer_vgw
  ]
}

resource "aws_customer_gateway" "customer_cgw" {
  for_each   = aviatrix_spoke_gateway.spoke_gw
  bgp_asn    = 65000 #placeholder asn
  ip_address = each.value.eip
  type       = "ipsec.1"

  tags = {
    Name = "cgw-${each.key}"
  }

  depends_on = [
    aviatrix_spoke_gateway.spoke_gw
  ]
}

resource "aws_vpn_connection" "vgw_cgw_connection" {
  count               = length(aws_vpn_gateway.customer_vgw)
  vpn_gateway_id      = aws_vpn_gateway.customer_vgw[keys(var.aws_vpc.customer_vpc)[count.index]].id
  customer_gateway_id = aws_customer_gateway.customer_cgw[keys(var.aws_vpc.spoke_vpc)[count.index]].id
  type                = "ipsec.1"
  static_routes_only  = true

  tags = {
    Name = "vgw-cgw-${keys(var.aws_vpc.customer_vpc)[count.index]}-connection"
  }

  depends_on = [
    aws_vpn_gateway_attachment.vgw_attachment,
    aws_customer_gateway.customer_cgw
  ]
}

# Detached vgw
resource "aws_vpn_gateway" "detached_vgw" {
  tags = {
    Name = "vgw-detached"
  }

  depends_on = [
    aviatrix_vpc.aws_onprem_vpc
  ]
}