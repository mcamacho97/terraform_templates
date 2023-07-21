resource "aws_instance" "MyFirstInstance" {
  ami           = "ami-0af9d24bd5539d7af"
  instance_type = "t2.micro"

  tags = {
    Name = "demoinstance"
  }
}