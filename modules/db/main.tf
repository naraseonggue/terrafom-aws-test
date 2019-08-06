resource "aws_security_group" "rds" {
  name = "${format("%s-rds-sg", var.name)}"

  vpc_id = "${module.vpc.vpc_id}"

  ingress {
    from_port   = "${var.db_port}"
    to_port     = "${var.db_port}"
    protocol    = "tcp"
    cidr_blocks = ["${module.vpc.private_subnets_cidr_blocks}"]
  }

  tags {
    Group = "${var.name}"
  }
}
