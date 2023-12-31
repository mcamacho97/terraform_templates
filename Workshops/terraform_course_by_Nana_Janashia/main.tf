provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA3Y6KYJHQDDFVMMR7"
  secret_key = "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"
}

variable "subnet_cidr_block" {
  description = "subnet cidr block"
  default = "10.0.50.0/24"
  type = string
}

variable "vpc_cidr_block" {
  description = "vpc cidr block"
  default = "10.0.0.0/16"
}

resource "aws_vpc" "development-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "development"
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id            = aws_vpc.development-vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = "us-east-1a"
  tags = {
    Name : "subnet-1-dev"
  }
}

# data "aws_vpc" "existing_vpc" {
#   default = true
# }

# resource "aws_subnet" "dev-subnet-2" {
#   vpc_id            = data.aws_vpc.existing_vpc.id
#   cidr_block        = "172.31.64.0/20"
#   availability_zone = "us-east-1a"
# }

output "dev-vpc-id" {
  value = aws_vpc.development-vpc.id
}

output "dev-subnet-id" {
  value = aws_subnet.dev-subnet-1.id
}