resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = var.vpc_name
    }

}

resource "aws_vpc_dhcp_options" "dhcp_options" {
  domain_name         = var.domain
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_vpc_dhcp_options_association" "dhcp_options_association" {
  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp_options.id
}

resource "aws_subnet" "subnet" {
  count = var.subnets_count

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 2, count.index)
  availability_zone = element(data.aws_availability_zones.zones_available.names, count.index)

  tags = {
    Name = "${var.vpc_name}-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name}-internet-gateway"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.vpc_name}-route-table"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.route_table.id
  count = var.subnets_count
}

resource "aws_route" "internet" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}