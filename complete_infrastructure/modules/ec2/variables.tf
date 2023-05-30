variable "key_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ec2_ami_id" {
  type = string
}

variable "nat_ec2_ami_id" {
  type = string
}

variable "ec2_instance_type" {
  type = string
}

variable "first_public_subnet_id" {
  type = string
}

variable "second_public_subnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "first_public_subnet_cidr_block" {
  type = string
}

variable "second_public_subnet_cidr_block" {
  type = string
}

variable "rds_address" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "bucket_force_destroy" {
  type = bool
}

variable "jars_filepath" {
  type = string
}
