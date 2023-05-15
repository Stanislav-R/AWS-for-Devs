### IAM ###

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-6.1-x86_64"]
  }
}

data "aws_s3_bucket" "my_bucket" {
  bucket = "srudyi-s3-demo"
}

resource "aws_iam_role" "ec2_iam_role" {
  name = "ec2_iam_role"

  assume_role_policy = jsonencode({
    "Version" = "2012-10-17"
    "Statement" = [
      {
        "Action" = "sts:AssumeRole"
        "Effect" = "Allow"
        "Sid"    = ""
        "Principal" = {
          "Service" = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "s3_policy" {
  name        = "s3-policy"
  path        = "/"
  description = "Allow "

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ],
        "Resource" : [
          "arn:aws:s3:::*/*",
          "arn:aws:s3:::srudyi-s3-demo"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "bucket_policy" {
  role       = aws_iam_role.ec2_iam_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_iam_role.name
}

### Instance ###

resource "aws_instance" "ec2_instance" {
  ami                  = data.aws_ami.amazon-linux-2.id
  instance_type        = var.instance_size
  key_name             = var.aws_key_name
  security_groups      = ["${aws_security_group.public.name}"]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.id

  user_data = <<EOF
#!/bin/bash
yum update -y
sudo yum install -y postgresql15
aws s3 cp s3://${data.aws_s3_bucket.my_bucket.bucket} ${var.destination_folder} --recursive --exclude "*" --include "*script*"
EOF

  tags = {
    Name = "Instance with s3 access"
  }
}

### Databases ###

resource "aws_dynamodb_table" "tf_notes_table" {
 name           = "tf-notes-table"
 billing_mode   = "PROVISIONED"
 read_capacity  = "20"
 write_capacity = "20"
 hash_key       = "noteId"
 attribute {
  name = "noteId"
  type = "S"
 }
}

resource "aws_db_instance" "aws_rds_postgres" {
  identifier             = var.identifier
  instance_class         = var.aws_pg_instance_class
  allocated_storage      = var.aws_pg_allocated_storage
  db_name                = var.aws_pg_db_name
  engine                 = var.aws_pg_engine
  engine_version         = var.aws_pg_engine_version
  username               = var.aws_pg_username
  password               = var.aws_pg_password
  vpc_security_group_ids = [aws_security_group.databases.id]

  skip_final_snapshot  = true
  apply_immediately    = true
  publicly_accessible  = true
}