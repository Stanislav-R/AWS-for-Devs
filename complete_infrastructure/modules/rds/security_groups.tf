### RDS Security Groups ###
resource "aws_security_group" "rds_security_group" {
  name        = "database-sg"
  description = "Database internet access"
  vpc_id      = var.vpc_id
  tags = {
    Name = "Database Internet Access"
  }
}

resource "aws_security_group_rule" "postgres_in" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds_security_group.id
}

resource "aws_security_group_rule" "postgres_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds_security_group.id
}
