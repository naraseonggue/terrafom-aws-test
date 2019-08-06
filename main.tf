provider "aws"{
    region              =   "${var.aws_region}"
    version             =   "~> 2.1"
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
    sre-aws-mgmtvm_ip           =   "${var.sre-aws-mgmtvm_ip}"
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

module "db" {
  source                        =   "./modules/db"

  identifier                    =   "${var.db_identifier}"
  
  storage_type                  =   "gp2"
  engine                        =   "mysql"
  engine_version                =   "5.7"
  instance_class                =   "db.t2.micro"
  allocated_storage             =   20

  name                          =   "${var.db_name}"
  username                      =   "${var.db_username}"
  password                      =   "${var.db_password}"
  port                          =   "${var.db_port}"

  vpc_security_group_ids        =   ["${aws_security_group.rds.id}"]
  
  # disable backups to create DB faster
  backup_retention_period = "${var.db_backup_retention_period}"
  subnet_ids = ["${module.vpc.database_subnets}"]
  tags {
    Group = "${var.name}"
  }
}
 
module "elb" {
    source                      =   "./modules/elb"
}
