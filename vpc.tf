terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "Customvpc" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_internet_gateway" "mygateway" {
  vpc_id = aws_vpc.Customvpc.id

  tags = {
    Name = "IGW"
  }
}
resource "aws_route" "myroute" {
  route_table_id            = aws_vpc.Customvpc.main_route_table_id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.mygateway.id
}

resource "aws_subnet" "mysubt" {
  vpc_id     = aws_vpc.Customvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "public_sub"
  }
}
