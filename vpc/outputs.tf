output "vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "route_table_id" {
  value = aws_route_table.route_table.id
}

output "subnet_ids" {
  value = aws_subnet.subnet.*.id
}