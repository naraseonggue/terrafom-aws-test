# Security Group
resource "aws_security_group" "public_sg" {
  name        = "${var.sg_prefix}-public-sg"
  vpc_id      = "${var.vpc_id}"

  # Outbound ALL
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.sg_prefix}-public-sg"
    Managed_by = "terraform"
  }
}

resource "aws_security_group_rule" "sre-aws-mgmtvm_access_ingress" {
  security_group_id             = "${aws_security_group.public_sg.id}"
  description                   = "Allow ALL traffic for sre-aws-mgmtvm"
  cidr_blocks                   = ["${var.sre-aws-mgmtvm_ip}/32"]
  from_port                     = 0
  protocol                      = "-1"
  to_port                       = 0
  type                          = "ingress"
}

# Security Group for Private
resource "aws_security_group" "private_sg" {
  name        = "${var.sg_prefix}-private-sg"
  vpc_id      = "${var.vpc_id}"

  # Outbound ALL
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.sg_prefix}-private-sg"
    Managed_by = "terraform"
  }
}

resource "aws_security_group_rule" "sg_access_ingress" {
  security_group_id             = "${aws_security_group.private_sg.id}"
  description                   = "Allow ALL traffic public sg only"
  source_security_group_id      = "${aws_security_group.public_sg.id}"
  from_port                     = 0
  protocol                      = "-1"
  to_port                       = 0
  type                          = "ingress"
}
