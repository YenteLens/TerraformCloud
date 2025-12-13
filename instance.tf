resource "aws_instance" "example" {
  ami           = "ami-049442a6cf8319180"
  instance_type = "t3.micro"
}
