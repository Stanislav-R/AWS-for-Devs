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

