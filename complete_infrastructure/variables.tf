# variable "AWS_ACCESS_KEY" {}
# variable "AWS_SECRET_KEY" {}

variable "aws_region" {
  type        = string
  default     = "us-west-2"
  description = "The region of Your VPC"
}

variable "key_name" {
  type        = string
  default     = "stanislav-aws-us-west-2"
  description = "The name of your KeyPair"
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "IP range of Your VPC"
}

variable "first_public_subnet_cidr_block" {
  type        = string
  default     = "10.0.1.0/24"
  description = "IP range of the first public subnet"
}

variable "second_public_subnet_cidr_block" {
  type        = string
  default     = "10.0.2.0/24"
  description = "IP range of the second public subnet"
}

variable "first_public_subnet_az" {
  type        = string
  default     = "us-west-2a"
  description = "AZ of the first public subnet"
}

variable "second_public_subnet_az" {
  type        = string
  default     = "us-west-2b"
  description = "AZ of the second public subnet"
}

variable "first_private_subnet_cidr_block" {
  type        = string
  default     = "10.0.5.0/24"
  description = "IP range of the first private subnet"
}

variable "second_private_subnet_cidr_block" {
  type        = string
  default     = "10.0.6.0/24"
  description = "IP range of the second public subnet"
}

variable "first_private_subnet_az" {
  type        = string
  default     = "us-west-2c"
  description = "AZ of the first private subnet"
}

variable "second_private_subnet_az" {
  type        = string
  default     = "us-west-2d"
  description = "AZ of the second private subnet"
}

variable "ec2_ami_id" {
  type        = string
  default     = "data.aws_ami.amazon-linux-2.id"
  description = "Image ID for creating EC2 Instance"
}

variable "nat_ec2_ami_id" {
  type        = string
  default     = "ami-0b8889f9dd66fbacf"
  description = "Image ID for creating NAT EC2 Instance"
}

variable "ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Instance type for creating EC2"
}

variable "bucket_name" {
  type        = string
  default     = "srudyi-s3-bucket"
  description = "The name of Your S3 Bucket"
}

variable "bucket_force_destroy" {
  type        = bool
  default     = false
  description = "The bucket and all objects should be destroyed when using true"
}

variable "jars_filepath" {
  type        = string
  default     = "./docs"
  description = "The route to jar files on a storage device"
}

variable "dynamodb_table_name" {
  type        = string
  default     = "edu-lohika-training-aws-dynamodb"
  description = "The name of Your DynamoDB table"
}

variable "rds_identifier" {
  type        = string
  default     = "rds-postgres"
  description = "Indentifier of RDS instance"
}

variable "rds_dbname" {
  type        = string
  default     = "EduLohikaTrainingAwsRds"
  description = "The name of Your Postgres DB"
}

variable "rds_instance_class" {
  type        = string
  default     = "db.t2.micro"
  description = "Instance type for creating RDS instance"
}

variable "rds_allocated_storage" {
  type        = number
  default     = 20
  description = "The amount of storage allocated to RDS"
}

variable "rds_storage_type" {
  type        = string
  default     = "gp2"
  description = "Storage type of RDS"
}

variable "rds_engine" {
  type        = string
  default     = "postgres"
  description = "Amazon RDS DB engine"
}

variable "rds_engine_version" {
  type        = string
  default     = "12.7"
  description = "Amazon RDS DB engine version"
}

variable "rds_username" {
  type        = string
  default     = "rootuser"
  description = "Your database username"
}

variable "rds_password" {
  type        = string
  default     = "rootuser"
  description = "Your database password"
}

variable "sns_topic_name" {
  type        = string
  default     = "edu-lohika-training-aws-sns-topic"
  description = "SNS topic name"
}

variable "sqs_quene_name" {
  type        = string
  default     = "edu-lohika-training-aws-sqs-queue"
  description = "SQS quene name"
}
