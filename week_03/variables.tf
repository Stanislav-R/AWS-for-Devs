variable "aws_region" {
  default = "us-west-2"
  description = "AWS Region"
}

variable "aws_key_name" {
  default = "stanislav-aws-us-west-2"
  description = "The name of your KeyPair"
}

variable "instance_size" {
  default     = "t2.micro"
  description = "EC2 instance size  "
}

variable "destination_folder" {
  default     = "/home/ec2-user/"
  description = "Catalog for saving S3 files"
}

### AWS PostgreSQL ###

variable "identifier" {
  type        = string
  default = "demopostgres"
}

variable "aws_pg_db_name" {
  type        = string
  default = "demodb"
}

variable "aws_pg_allocated_storage" {
  type        = number
  default = 20
}

variable "aws_pg_engine" {
    type = string
    default = "postgres"
}

variable "aws_pg_engine_version" {
    type = string
    default = "15.2"
}

variable "aws_pg_instance_class" {
    type = string
    default = "db.t3.micro"
}

variable "aws_pg_username"{
    type = string
    default = "dbuser"
}

variable "aws_pg_password" {
  type = string
  default= "dbpassword"
}

