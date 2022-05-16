resource "aws_launch_template" "iac-template" {
  name = "iac-template"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 8
    }
  }

  ebs_optimized = false

  image_id = "ami-0ed11f3863410c386"

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = true
    subnet_id = aws_subnet.iac-public-subnet.id
    security_groups = [aws_security_group.terraform-iac-ec2-sg.id]
  }

  placement {
    availability_zone = "ap-northeast-2a"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "iac-template"
    }
  }

  user_data = filebase64("./user_data.sh")
}

variable "server_port" {
  default = 80
}