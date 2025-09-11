############################
# Route Tables
############################
# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.eks_vpc.id
  tags   = { Name = "eks-public-rt" }
}

# Public route to IGW
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate public subnets
resource "aws_route_table_association" "public1_assoc" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public2_assoc" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_rt.id
}

# Elastic IPs for NAT
resource "aws_eip" "nat_eip1" {
  domain = "vpc"
}

resource "aws_eip" "nat_eip2" {
  domain = "vpc"
}

# NAT Gateways
resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.nat_eip1.id
  subnet_id     = aws_subnet.public1.id
  depends_on    = [aws_internet_gateway.igw]
  tags          = { Name = "eks-nat-1" }
}

resource "aws_nat_gateway" "nat2" {
  allocation_id = aws_eip.nat_eip2.id
  subnet_id     = aws_subnet.public2.id
  depends_on    = [aws_internet_gateway.igw]
  tags          = { Name = "eks-nat-2" }
}

# Private Route Tables
resource "aws_route_table" "private_rt1" {
  vpc_id = aws_vpc.eks_vpc.id
  tags   = { Name = "eks-private-rt1" }
}

resource "aws_route_table" "private_rt2" {
  vpc_id = aws_vpc.eks_vpc.id
  tags   = { Name = "eks-private-rt2" }
}

# Routes for private subnets to NAT
resource "aws_route" "private1_nat" {
  route_table_id         = aws_route_table.private_rt1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat1.id
}

resource "aws_route" "private2_nat" {
  route_table_id         = aws_route_table.private_rt2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat2.id
}

# Associate private subnets
resource "aws_route_table_association" "private1_assoc" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private_rt1.id
}

resource "aws_route_table_association" "private2_assoc" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private_rt2.id
}
