# VPC
resource "aws_vpc" "vpc" {
    cidr_block              =   "${var.vpc_cidr_block}"
    enable_dns_support      =   "true"
    enable_dns_hostnames    =   "true"
    
    tags                    = "${ 
        map(    
            "Name", "${var.vpc_name}",
            "Managed_by", "terraform",
        )
    }"
}

# Subnet
resource "aws_subnet" "vpc_public_subnet" {
    count               =   "${length(var.vpc_public_subnets)}"
    vpc_id              =   "${aws_vpc.vpc.id}"
    availability_zone   =   "${lookup(var.vpc_public_subnets[count.index], "az")}"
    cidr_block          =   "${lookup(var.vpc_public_subnets[count.index], "cidr")}"

    tags                =   "${
        map(
            "Name", "${var.vpc_name}-${lookup(var.vpc_public_subnets[count.index], "name")}",
            "Managed_by", "terraform",
            "Tier", "public"
        )
    }"
}

resource "aws_subnet" "vpc_private_subnet" {
    count               =   "${length(var.vpc_private_subnets)}"
    vpc_id              =   "${aws_vpc.vpc.id}"
    availability_zone   =   "${lookup(var.vpc_private_subnets[count.index], "az")}"
    cidr_block          =   "${lookup(var.vpc_private_subnets[count.index], "cidr")}"
    
    tags                =   "${
        map(
            "Name", "${var.vpc_name}-${lookup(var.vpc_private_subnets[count.index], "name")}",
            "Managed_by", "terraform",
            "Tier", "private"
        )
    }"
}

# Gateway
resource "aws_internet_gateway" "vpc_igw" {
    count               =   "${length(var.vpc_public_subnets) > 0 ? 1 : 0}"
    vpc_id              =   "${aws_vpc.vpc.id}"

    tags                =    {
        Name            =   "${var.vpc_name}-igw"
        Managed_by      =   "terraform"
    }
}

# Route table
resource "aws_route_table" "vpc_public_rtable" {
    count               =   "${length(var.vpc_public_subnets) > 0 ? 1 : 0}"
    vpc_id              =   "${aws_vpc.vpc.id}"

    route {
        cidr_block      =   "0.0.0.0/0"
        gateway_id      =   "${aws_internet_gateway.vpc_igw[0].id}"
    }

    tags                =   {
        Name            =   "${var.vpc_name}-public-rt"
        Managed_by      =   "terraform"
    }
}

resource "aws_route_table" "vpc_private_rtable" {
    count               =   "${length(var.vpc_private_subnets) > 0 ? 1 : 0}"
    vpc_id              =   "${aws_vpc.vpc.id}"

    route {
        cidr_block      =   "0.0.0.0/0"
        nat_gateway_id  =   "${aws_nat_gateway.vpc_ngw[0].id}"
    }

    tags                =   {
        Name            =   "${var.vpc_name}-private-rt"
        Managed_by      =   "terraform"
    }
}

resource "aws_route_table_association" "vpc_public_rtable_association" {
    count           =   "${length(var.vpc_public_subnets)}"

    subnet_id       =   "${aws_subnet.vpc_public_subnet.*.id[count.index]}"
    route_table_id  =   "${aws_route_table.vpc_public_rtable[0].id}"
}

resource "aws_route_table_association" "vpc_private_rtable_association" {
    count           =   "${length(var.vpc_private_subnets)}"

    subnet_id       =   "${aws_subnet.vpc_private_subnet.*.id[count.index]}"
    route_table_id  =   "${aws_route_table.vpc_private_rtable[0].id}"
}

# NAT gateway
resource "aws_eip" "eip_ngw" {
  count     =   "${length(var.vpc_public_subnets) > 0 ? 1 : 0}"
  vpc       =   true

  tags      =   {
      Name            =   "${var.vpc_name}-nat-eip"
      Managed_by      =   "terraform"
  }
}

resource "aws_nat_gateway" "vpc_ngw" {
  count         =   "${length(var.vpc_public_subnets) > 0 ? 1 : 0}"

  allocation_id =   "${aws_eip.eip_ngw[0].id}"
  subnet_id     =   "${aws_subnet.vpc_public_subnet.*.id[0]}"

  tags          =   {
      Name            =   "${var.vpc_name}-nat-gateway"
      Managed_by      =   "terraform"
  }
}
