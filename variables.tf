variable "project_name" {}
variable "cloud9_ip" {}

variable "aws_region" {
    default     =   "ap-northeast-2"
}

variable "vpc_cidr_block" {
    default     =   "192.168.2.0/25"
}

variable "vpc_public_subnets" {
    default = [
        {
            "az"    =   "ap-northeast-2a",
            "cidr"  =   "192.168.2.0/27",
            "name"  =   "public-subnet-01"
        },
        {
            "az"    =   "ap-northeast-2c",
            "cidr"  =   "192.168.2.32/27",
            "name"  =   "public-subnet-02"
        },
    ]
    description     =   "Subnet list to use for network to connect to the internet in this VPC"
    type            =   "list"
}

variable "vpc_private_subnets" {
    default = [
        {
            "az"    =   "ap-northeast-2a",
            "cidr"  =   "192.168.2.64/27",
            "name"  =   "private-subnet-01"
        },
        {
            "az"    =   "ap-northeast-2c",
            "cidr"  =   "192.168.2.96/27",
            "name"  =   "private-subnet-02"
        },
    ]
    description     =   "CIDR Blocks of subnet to use for internal network in this VPC"
    type            =   "list"
}

variable "vpc_id" {
    default     =   ""
    description =   "The ID of VPC"
}

