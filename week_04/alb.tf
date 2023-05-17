### ALB ###
resource "aws_lb_target_group" "demo_target_group" {
  name        = "demo-target-group"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.demo_vpc.id

  health_check {
    enabled             = true
    interval            = 10
    path                = "/index.html"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }
}

resource "aws_lb" "demo_alb" {
  name               = "demo-alb"
  internal           = false
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_public.id]
  subnets            = [aws_subnet.demo_pubic_subnet.id, aws_subnet.demo_private_subnet.id]

  tags = {
    Name = "demo-alb"
  }
}

resource "aws_lb_listener" "demo_alb_listener" {
  load_balancer_arn  = aws_lb.demo_alb.arn
  port               = 80
  protocol           = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.demo_target_group.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "ec2_attach_1" {
  target_group_arn = aws_lb_target_group.demo_target_group.arn
  target_id = aws_instance.ec2_public_instance.id
}

resource "aws_lb_target_group_attachment" "ec2_attach_2" {
  target_group_arn = aws_lb_target_group.demo_target_group.arn
  target_id = aws_instance.ec2_privat_instance.id
}