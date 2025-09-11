############################
# VPC
############################
resource "aws_vpc" "eks_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = { Name = "eks-vpc" }
}

############################
# Internet Gateway (for public subnets)
############################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.eks_vpc.id
  tags   = { Name = "eks-igw" }
}

############################
# Public Subnets
############################
resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = { Name = "eks-public-1" }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true

  tags = { Name = "eks-public-2" }
}

############################
# Private Subnets
############################
resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-west-2a"

  tags = { Name = "eks-private-1" }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-west-2b"

  tags = { Name = "eks-private-2" }
}
