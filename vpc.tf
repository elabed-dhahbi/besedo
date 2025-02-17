resource "aws_vpc" "technical_test_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = "${var.default_tags.project}-vpc"
  }
  instance_tenancy = "default"
  enable_dns_hostnames =  true
  enable_dns_support = true
}
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.technical_test_vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "technical-test-public"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.technical_test_vpc.id
  cidr_block = var.private_subnet_cidr
  tags = {
    Name = "technical-test-private"
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.technical_test_vpc.id
  tags = {
    Name = "technical-test-public-route-table"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.technical_test_vpc.id
  tags = {
    Name = "technical-test-gateway"
  }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public.id
}
resource "aws_eip" "nat" {
  vpc = true
  tags = {
    Name = "technical-test-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    Name = "technical-test-nat"
  }
  depends_on = [aws_internet_gateway.gw]
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.technical_test_vpc.id
  tags = {
    Name = "technical-test-private-route-table"
  }
}
resource "aws_route" "private_internet_access" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private.id
}
