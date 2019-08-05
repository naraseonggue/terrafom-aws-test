variable "project_name" {}
variable "cloud9_ip" {}

variable "aws_region" {
    default     =   "ap-northeast-2"
}

variable "vpc_cidr_block" {
    default     =   "172.16.0.0/16"
}

variable "vpc_public_subnets" {
    default = [
        {
            "az"    =   "ap-northeast-2a",
            "cidr"  =   "172.16.1.0/24",
            "name"  =   "public-subnet-01"
        },
        {
            "az"    =   "ap-northeast-2b",
            "cidr"  =   "172.16.2.0/24",
            "name"  =   "public-subnet-02"
        },
        {
            "az"    =   "ap-northeast-2c",
            "cidr"  =   "172.16.3.0/24",
            "name"  =   "public-subnet-03"
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
            "name"  =   "private-subnet-01"
        },
        {
            "az"    =   "ap-northeast-2b",
            "cidr"  =   "172.16.17.0/24",
            "name"  =   "private-subnet-02"
        },
        {
            "az"    =   "ap-northeast-2c",
            "cidr"  =   "172.16.18.0/24",
            "name"  =   "private-subnet-03"
        }
    ]
    description     =   "CIDR Blocks of subnet to use for internal network in this VPC"
    type            =   "list"
}

variable "vpc_id" {
    default     =   ""
    description =   "The ID of VPC"
}

