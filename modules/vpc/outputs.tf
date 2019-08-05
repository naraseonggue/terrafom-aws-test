output "vpc_id" {
    description =   "The ID of VPC"
    value       =   "${aws_vpc.vpc.id}"
}

output "vpc_name" {
    description =   "The name of VPC"
    value       =   "${aws_vpc.vpc.tags.Name}"
}

output "vpc_cidr_block" {
    description =   "CIDR Block of VPC to use for network"
    value       =   "${aws_vpc.vpc.cidr_block}"
}

output "vpc_public_subnet_ids" {
    description =   "The ID list of public subnets in this VPC"
    value       =   "${aws_subnet.vpc_public_subnet.*.id}"
}

output "vpc_private_subnet_ids" {
    description =   "The ID list of private subnets in this VPC"
    value       =   "${aws_subnet.vpc_private_subnet.*.id}"
}

output "vpc_public_route_table_ids" {
    description =   "The ID list of route tables for public network in this VPC"
    value       =   "${aws_route_table.vpc_public_rtable.*.id}"
}

output "vpc_private_route_table_ids" {
    description =   "The ID list of route tables for private network in this VPC"
    value       =   "${aws_route_table.vpc_private_rtable.*.id}"
}
