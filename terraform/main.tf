resource "aws_vpc" "scribbles_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "scribbles_vpc"
  }
}

resource "aws_subnet" "scribbles_vpc_sn" {
  vpc_id                  = aws_vpc.scribbles_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "scribbles_vpc_sn"
  }
}

resource "aws_route_table" "scribbles_vpc_rt" {
  vpc_id = aws_vpc.scribbles_vpc.id

  tags = {
    Name = "scribbles_vpc_rt"
  }
}

resource "aws_internet_gateway" "scribbles_vpc_igw" {
  vpc_id = aws_vpc.scribbles_vpc.id

  tags = {
    Name = "scribbles_vpc_igw"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.scribbles_vpc_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.scribbles_vpc_igw.id
}

resource "aws_route_table_association" "scribbles_vpc_rt_assoc" {
  subnet_id      = aws_subnet.scribbles_vpc_sn.id
  route_table_id = aws_route_table.scribbles_vpc_rt.id
}

resource "aws_security_group" "scribbles_vpc_sg" {
  vpc_id = aws_vpc.scribbles_vpc.id

  tags = {
    Name = "scribbles_vpc_sg"
  }
}

resource "aws_security_group_rule" "ssh_rule" {
  security_group_id = aws_security_group.scribbles_vpc_sg.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["111.125.255.126/32"]
}

resource "aws_security_group_rule" "internet_ingress_rule" {
  security_group_id = aws_security_group.scribbles_vpc_sg.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "internet_egress_rule" {
  security_group_id = aws_security_group.scribbles_vpc_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_key_pair" "scribbles_keypair" {
  key_name   = "scribbles"
  public_key = file("~/.ssh/scribbles.pub")
}

resource "aws_instance" "scribbles_ec2" {
  ami                    = "ami-053b0d53c279acc90"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.scribbles_keypair.id
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.scribbles_vpc_sg.id]
  subnet_id = aws_subnet.scribbles_vpc_sn.id

  # user_data = filebase64("/userdata.sh")

  tags = {
    Name = "scribbles_ec2"
  }
}
