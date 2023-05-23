### IAM ###
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-6.1-x86_64"]
  }
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
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
  ]
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
  security_groups      = [aws_security_group.public.name]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.id

  tags = {
    Name = "Demo Instance"
  }
}