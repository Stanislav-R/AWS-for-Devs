### Postgres instance ###
resource "aws_db_instance" "postgres_instance" {
  identifier             = var.rds_identifier
  db_name                = var.rds_dbname
  instance_class         = var.rds_instance_class
  allocated_storage      = var.rds_allocated_storage
  storage_type           = var.rds_storage_type
  engine                 = var.rds_engine
  engine_version         = var.rds_engine_version
  username               = var.rds_username
  password               = var.rds_password
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.id

  skip_final_snapshot = true
  apply_immediately   = true
  publicly_accessible = true
}

resource "aws_db_subnet_group" "db_subnet_group" {
  subnet_ids = [
    var.privat_subnet_1_id,
    var.privat_subnet_2_id
  ]
}
