resource "aws_lb" "terraform-iac-alb" {
  name               = "terraform-iac-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.terraform-iac-alb-sg.id]
  subnets            = [aws_subnet.iac-public-subnet.id, aws_subnet.iac-public-subnet-2.id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "iac-tg" {
  name     = "iac-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.terraform-iac-vpc.id
}

resource "aws_lb_listener" "alb-tg-ec2" {
  load_balancer_arn = aws_lb.terraform-iac-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.iac-tg.arn
  }
}