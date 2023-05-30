### Application Load Balancer ###
resource "aws_lb_target_group" "load_balancer_target_group" {
  name        = "target-group"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    interval            = 10
    path                = "/actuator/health"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }
}

resource "aws_lb" "load_balancer" {
  name               = "load-balancer"
  internal           = false
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balancer_security_group.id]
  subnets            = [var.first_public_subnet_id, var.second_public_subnet_id]

  tags = {
    Name = "application-load-balancer"
  }
}

resource "aws_lb_listener" "load_balancer_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.load_balancer_target_group.arn
    type             = "forward"
  }
}

### Target Group attachment ###
resource "aws_autoscaling_attachment" "asg_attach" {
  lb_target_group_arn    = aws_lb_target_group.load_balancer_target_group.arn
  autoscaling_group_name = aws_autoscaling_group.public_subnet_autoscaling_group.id
}
