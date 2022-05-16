resource "aws_autoscaling_group" "terraform-iac-asg" {
  availability_zones = ["ap-northeast-2a"]
  desired_capacity   = 2
  max_size           = 10
  min_size           = 2

  launch_template {
    id      = "${aws_launch_template.iac-template.id}"
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "iac-asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.terraform-iac-asg.id
  alb_target_group_arn    = aws_lb_target_group.iac-tg.arn
} 