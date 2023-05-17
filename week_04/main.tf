### Instance ###

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-6.1-x86_64"]
  }
}

resource "aws_instance" "nat_instance" {
  ami                  = "ami-0d0d4bd4d29bcc39f"
  instance_type        = var.instance_size
  key_name             = var.aws_key_name
  security_groups      = [aws_security_group.public.id]
  subnet_id = aws_subnet.demo_pubic_subnet.id
  source_dest_check = false

  tags = {
    Name = "nat-instance"
  }
}

resource "aws_instance" "ec2_public_instance" {
  ami                  = data.aws_ami.amazon-linux-2.id
  instance_type        = var.instance_size
  key_name             = var.aws_key_name
  security_groups      = [aws_security_group.public.id]
  subnet_id = aws_subnet.demo_pubic_subnet.id

  user_data = <<-EOF
        #!/bin/bash
        sudo su
        yum update -y
        yum install httpd -y
        systemctl start httpd
        systemctl enable httpd
        cd /var/www/html
        echo "<html><h1> This is WebServer from public subnet with $(hostname -f) </h1></html>" > index.html
        EOF

  tags = {
    Name = "ec2-public-instance"
  }
}

resource "aws_instance" "ec2_privat_instance" {
  ami                  = data.aws_ami.amazon-linux-2.id
  instance_type        = var.instance_size
  key_name             = var.aws_key_name
  security_groups      = [aws_security_group.private.id]
  subnet_id = aws_subnet.demo_private_subnet.id

  user_data = <<-EOF
        #!/bin/bash
        sudo su
        yum update -y
        yum install httpd -y
        systemctl start httpd
        systemctl enable httpd
        cd /var/www/html
        echo "<html><h1> This is WebServer from private subnet with $(hostname -f) </h1></html>" > index.html
        EOF

  tags = {
    Name = "ec2-privat-instance"
  }
}