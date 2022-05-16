# VPC
resource "aws_vpc" "terraform-iac-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "terraform-iac-vpc"
  }
}

# Subnet
resource "aws_subnet" "iac-public-subnet" {
  vpc_id     = aws_vpc.terraform-iac-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "iac public subnet"
  }
}

resource "aws_subnet" "iac-private-subnet" {
  vpc_id     = aws_vpc.terraform-iac-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "iac private subnet"
  }
}

resource "aws_subnet" "iac-public-subnet-2" {
  vpc_id     = aws_vpc.terraform-iac-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "iac public subnet 2"
  }
}

resource "aws_subnet" "iac-private-subnet-2" {
  vpc_id     = aws_vpc.terraform-iac-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "iac private subnet 2"
  }
}

# resource "aws_eip" "byoip-ip" {
#   vpc = true
# }

resource "aws_internet_gateway" "terraform-iac-ig" {
  vpc_id = aws_vpc.terraform-iac-vpc.id

  tags = {
    Name = "terraform-iac-ig"
  }
}

# resource "aws_nat_gateway" "terraform-iac-ng" {
#   allocation_id = aws_eip.example.id
#   subnet_id     = aws_subnet.iac-private-subnet-2.id

#   tags = {
#     Name = "terraform-iac-ng"
#   }

#   # To ensure proper ordering, it is recommended to add an explicit dependency
#   # on the Internet Gateway for the VPC.
#   depends_on = [aws_internet_gateway.terraform-iac-ig]
# }

resource "aws_route_table" "terraform-iac-rt" {
  vpc_id = aws_vpc.terraform-iac-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-iac-ig.id
  }

  tags = {
    Name = "terraform-iac-rt"
  }
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.terraform-iac-vpc.id
  route_table_id = aws_route_table.terraform-iac-rt.id
}