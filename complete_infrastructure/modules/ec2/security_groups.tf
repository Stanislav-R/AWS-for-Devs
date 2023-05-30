### EC2 Security Groups ###
resource "aws_security_group" "public_subnet_security_group" {
  name        = "public-sg"
  description = "Public internet access"
  vpc_id      = var.vpc_id

  tags = {
    Name = "EC2 Public Access"
  }
}

resource "aws_security_group_rule" "public_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public_subnet_security_group.id
}

resource "aws_security_group_rule" "public_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public_subnet_security_group.id
}

resource "aws_security_group_rule" "public_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public_subnet_security_group.id
}

resource "aws_security_group_rule" "public_in_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public_subnet_security_group.id
}

resource "aws_security_group" "private_subnet_security_group" {
  name        = "private-sg"
  description = "Private internet access"
  vpc_id      = var.vpc_id

  tags = {
    Name = "EC2 Private Access"
  }
}

resource "aws_security_group_rule" "privat_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.private_subnet_security_group.id
}

resource "aws_security_group_rule" "private_in" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = [var.first_public_subnet_cidr_block, var.second_public_subnet_cidr_block]
  security_group_id = aws_security_group.private_subnet_security_group.id
}

## Load Balancer Security Groups ###
resource "aws_security_group" "load_balancer_security_group" {
  name        = "alb-sg"
  description = "ALB internet access"
  vpc_id      = var.vpc_id

  tags = {
    Name = "ALB Public Access"
  }
}

resource "aws_security_group_rule" "lb_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.load_balancer_security_group.id
}

resource "aws_security_group_rule" "lb_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.load_balancer_security_group.id
}

resource "aws_security_group_rule" "lb_in_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.load_balancer_security_group.id
}
