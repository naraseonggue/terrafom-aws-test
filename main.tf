provider "template" {
    version             = "~> 2.1"
}

provider "aws"{
    region              =   "${var.aws_region}"
}

module "vpc" { 
    source              =   "./modules/vpc"

    vpc_name            =   "${local.vpc_name}"
    vpc_cidr_block      =   "${var.vpc_cidr_block}"
    vpc_public_subnets  =   "${var.vpc_public_subnets}"
    vpc_private_subnets =   "${var.vpc_private_subnets}"   
}

module "security_group" {
    source                      =   "./modules/security_group"

    sg_prefix                   =   "${local.project_name}"
    vpc_id                      =   "${module.vpc.vpc_id}"
    vpc_cidr_block              =   "${module.vpc.vpc_cidr_block}"
    cloud9_ip                   =   "${var.cloud9_ip}"
}

module "ec2" {
    source                      =   "./modules/ec2"

    ec2_keypair                 =   "${local.project_name}-key"
    public_instance_name        =   "${local.project_name}-public-instance"
    private_instance_name       =   "${local.project_name}-private-instance"
    public_subnet_ids           =   "${module.vpc.vpc_public_subnet_ids}"
    private_subnet_ids          =   "${module.vpc.vpc_private_subnet_ids}"
    public_security_group_id    =   "${module.security_group.public_sg_id}"
    private_security_group_id   =   "${module.security_group.private_sg_id}"
}

