module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block = var.vpc_cidr_block

  first_public_subnet_cidr_block = var.first_public_subnet_cidr_block
  first_public_subnet_az         = var.first_public_subnet_az

  second_public_subnet_cidr_block = var.second_public_subnet_cidr_block
  second_public_subnet_az         = var.second_public_subnet_az

  first_private_subnet_cidr_block = var.first_private_subnet_cidr_block
  first_private_subnet_az         = var.first_private_subnet_az

  second_private_subnet_cidr_block = var.second_private_subnet_cidr_block
  second_private_subnet_az         = var.second_private_subnet_az
}

module "ec2" {
  source = "./modules/ec2"

  ec2_ami_id                      = module.ec2.latest_ami_id
  nat_ec2_ami_id                  = var.nat_ec2_ami_id
  ec2_instance_type               = var.ec2_instance_type
  key_name                        = var.key_name
  bucket_name                     = var.bucket_name
  bucket_force_destroy            = var.bucket_force_destroy
  jars_filepath                   = var.jars_filepath
  vpc_id                          = module.vpc.vpc_id
  first_public_subnet_cidr_block  = module.vpc.first_public_subnet_cidr_block
  second_public_subnet_cidr_block = module.vpc.second_public_subnet_cidr_block
  first_public_subnet_id          = module.vpc.first_public_subnet_id
  second_public_subnet_id         = module.vpc.second_public_subnet_id
  private_subnet_id               = module.vpc.first_private_subnet_id
  rds_address                     = module.postgres_instance.rds_address
}


module "dynamodb_table" {
  source              = "./modules/dynamodb"
  dynamodb_table_name = var.dynamodb_table_name
}

module "postgres_instance" {
  source = "./modules/rds"

  rds_identifier        = var.rds_identifier
  rds_dbname            = var.rds_dbname
  rds_instance_class    = var.rds_instance_class
  rds_allocated_storage = var.rds_allocated_storage
  rds_storage_type      = var.rds_storage_type
  rds_engine            = var.rds_engine
  rds_engine_version    = var.rds_engine_version
  rds_username          = var.rds_username
  rds_password          = var.rds_password

  vpc_id             = module.vpc.vpc_id
  privat_subnet_1_id = module.vpc.first_private_subnet_id
  privat_subnet_2_id = module.vpc.second_private_subnet_id
}

module "routing" {
  source = "./modules/routing"

  vpc_id                   = module.vpc.vpc_id
  first_public_subnet_id   = module.vpc.first_public_subnet_id
  second_public_subnet_id  = module.vpc.second_public_subnet_id
  first_private_subnet_id  = module.vpc.first_private_subnet_id
  second_private_subnet_id = module.vpc.second_private_subnet_id
  nat_ec2_instance_id      = module.ec2.nat_ec2_instance_id
}

module "messaging" {
  source = "./modules/messaging"

  sns_topic_name = var.sns_topic_name
  sqs_quene_name = var.sqs_quene_name
}
