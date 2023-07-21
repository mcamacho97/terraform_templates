provider "aws" {
    profile = "default"
    region = "us-east-1"
}

resource "aws_instance" "MyFirstInstance" {
    count = 3
    ami = ""
    instance_type = "t2.micro"

    tags = {
      Name = "demoinstance-${count.index}"
    }
}