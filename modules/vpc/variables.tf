variable "vpc_name" {}

variable "vpc_cidr_block" {
    default     =   "172.16.0.0/16"
}

variable "vpc_public_subnets" {
    default = [
        {
            "az"    =   "ap-northeast-2a",
            "cidr"  =   "172.16.1.0/24",
            "name"  =   "public-subnet-a"
        },
        {
            "az"    =   "ap-northeast-2b",
            "cidr"  =   "172.16.2.0/24",
            "name"  =   "public-subnet-b"
        },
        {
            "az"    =   "ap-northeast-2c",
            "cidr"  =   "172.16.3.0/24",
            "name"  =   "public-subnet-c"
        }
    ]
    description     =   "Subnet list to use for network to connect to the internet in this VPC"
    type            =   "list"
}

variable "vpc_private_subnets" {
    default = [
        {
            "az"    =   "ap-northeast-2a",
            "cidr"  =   "172.16.16.0/24",
            "name"  =   "private-subnet-a"
        },
        {
            "az"    =   "ap-northeast-2b",
            "cidr"  =   "172.16.17.0/24",
            "name"  =   "private-subnet-b"
        },
        {
            "az"    =   "ap-northeast-2c",
            "cidr"  =   "172.16.18.0/24",
            "name"  =   "private-subnet-c"
        }
    ]
    description     =   "CIDR Blocks of subnet to use for internal network in this VPC"
    type            =   "list"
}

