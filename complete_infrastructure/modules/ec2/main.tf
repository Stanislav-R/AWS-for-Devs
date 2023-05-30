### EC2 Template ###
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-6.1-x86_64"]
  }
}

data "template_file" "public_ec2_user_data" {
  template = <<-EOF
    #!/bin/bash
    sudo su

    yum update -y
    yum install -y postgresql12
    yum install -y java-1.8*

    aws s3api get-object --bucket ${var.bucket_name} --key calc-2021-0.0.2-SNAPSHOT.jar /opt/calc-2021-0.0.2-SNAPSHOT.jar

    java -jar /opt/calc-2021-0.0.2-SNAPSHOT.jar
    EOF
}

resource "aws_launch_template" "public_subnet_launch_template" {
  name          = "launch-template-for-public-subnet"
  image_id      = var.ec2_ami_id
  instance_type = var.ec2_instance_type
  key_name      = var.key_name
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }
  vpc_security_group_ids = [aws_security_group.public_subnet_security_group.id]

  user_data = base64encode(data.template_file.public_ec2_user_data.rendered)
}

### Auto Scaling Group ###
resource "aws_autoscaling_group" "public_subnet_autoscaling_group" {
  name             = "asg-for-public-subnet"
  max_size         = 2
  min_size         = 2
  desired_capacity = 2

  vpc_zone_identifier = [var.first_public_subnet_id, var.second_public_subnet_id]
  target_group_arns   = [aws_lb_target_group.load_balancer_target_group.arn]

  launch_template {
    id      = aws_launch_template.public_subnet_launch_template.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "public-ec2-instance"
    propagate_at_launch = true
  }
}

### Private EC2 Instance ###
resource "aws_instance" "private_subnet_ec2" {
  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [aws_security_group.private_subnet_security_group.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.id
  key_name               = var.key_name
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo su

    export RDS_HOST=${var.rds_address}
    echo $RDS_HOST

    yum -y update
    yum install -y java-1.8*
    yum install -y postgresql12
    
    aws s3api get-object --bucket ${var.bucket_name} --key persist3-2021-0.0.1-SNAPSHOT.jar /opt/persist3-2021-0.0.1-SNAPSHOT.jar

    java -jar /opt/persist3-2021-0.0.1-SNAPSHOT.jar
    EOF

  tags = {
    Name = "private-ec2-instance"
  }
}

### NAT EC2 Instance ###
resource "aws_instance" "nat_ec2" {
  ami                    = var.nat_ec2_ami_id
  instance_type          = var.ec2_instance_type
  subnet_id              = var.first_public_subnet_id
  key_name               = var.key_name
  source_dest_check      = false
  vpc_security_group_ids = [aws_security_group.public_subnet_security_group.id]

  tags = {
    Name = "nat-ec2-instance"
  }
}
