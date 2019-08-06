variable "vpc_name" {}

variable "vpc_cidr_block" {
    default     =   "192.168.2.0/25"
}

variable "vpc_public_subnets" {
    default = [
        {
            "az"    =   "ap-northeast-2a",
            "cidr"  =   "192.168.2.0/27",
            "name"  =   "public-subnet-a"
        },
        {
            "az"    =   "ap-northeast-2c",
            "cidr"  =   "192.168.2.32/27",
            "name"  =   "public-subnet-b"
        },
    ]
    description     =   "public subnet to connect to internet"
    type            =   "list"
}

variable "vpc_private_subnets" {
    default = [
        {
            "az"    =   "ap-northeast-2a",
            "cidr"  =   "192.168.2.64/27",
            "name"  =   "private-subnet-a"
        },
        {
            "az"    =   "ap-northeast-2c",
            "cidr"  =   "192.168.2.96/27",
            "name"  =   "private-subnet-b"
        },
    ]
    description     =   "private subnet"
    type            =   "list"
}

