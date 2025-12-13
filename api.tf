data "aws_vpc" "default" {
  default = true
}

resource "aws_instance" "example" {
  ami           = "ami-049442a6cf8319180"
  instance_type = "t3.micro"
  vpc_security_group_ids = [ aws_security_group.appsg.id ]

  #user_data = file("${path.module/user-data.sh}")
}

resource "aws_security_group" "appsg" {
  name = "appsg"
  description = "allow http and mysql"
  vpc_id = data.aws_vpc.default.id
  
}

resource "aws_security_group_rule" "allowhttp" {
  type = "ingress"
  from_port = 80 
  to_port = 80
  protocol = "tcp"
  security_group_id = aws_security_group.appsg.id
  cidr_blocks = ["0.0.0.0/0"]
    
}

resource "aws_security_group_rule" "allowmysql" {
  type = "ingress"
  from_port = 3306 
  to_port = 3306
  protocol = "tcp"
  security_group_id = aws_security_group.appsg.id
  cidr_blocks = ["0.0.0.0/0"]
  
}

resource "aws_security_group_rule" "allowmyssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  security_group_id = aws_security_group.appsg.id
  cidr_blocks = ["0.0.0.0/0"]
  
}

resource "aws_security_group_rule" "allowmyall" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.appsg.id
  cidr_blocks = ["0.0.0.0/0"]
  
}