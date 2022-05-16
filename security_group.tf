resource "aws_security_group" "terraform-iac-ec2-sg" {
  name        = "terraform-iac-ec2-sg"
  description = "Security Group for EC2"
  vpc_id      = aws_vpc.terraform-iac-vpc.id

  ingress {
    description      = "from ALB"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups = [ aws_security_group.terraform-iac-alb-sg.id ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "terraform-iac-ec2-sg"
  }

  depends_on = [
    aws_vpc.terraform-iac-vpc
  ]
}

resource "aws_security_group" "terraform-iac-alb-sg" {
  name        = "terraform-iac-alb-sg"
  description = "Security Group for ALB"
  vpc_id      = aws_vpc.terraform-iac-vpc.id

  ingress {
    description      = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "terraform-iac-alb-sg"
  }
} 