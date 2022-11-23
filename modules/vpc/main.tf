########### VPC ###########
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.dns_enable

  tags = {
    Name = "${var.env}-vpc"
  }
}
############ subnets ###########
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidrs[count.index]
  count                   = length(var.public_cidrs)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = var.public_ip_map

  tags = {
    Name = "${var.env}-public-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_cidrs[count.index]
  count             = length(var.private_cidrs)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.env}-private-${count.index + 1}"
  }
}
############ IGW ################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}-igw"
  }
}
############ PUBLIC ROUTE ##############
resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.env}-Public_RT"
  }
}
resource "aws_route_table_association" "public_route" {
  count          = length(var.public_cidrs)
  subnet_id      = aws_subnet.public_subnet.*.id[count.index]
  route_table_id = aws_route_table.publicrt.id
}
############# PRIVATE ROUTE ###################
resource "aws_route_table" "privatert" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "${var.env}-privateRT"
  }
}

resource "aws_route_table_association" "private_route" {
  count          = length(var.private_cidrs)
  subnet_id      = aws_subnet.private_subnet.*.id[count.index]
  route_table_id = aws_route_table.privatert.id
}
################### NAT ################
resource "aws_eip" "dev" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.dev.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "${var.env}-NAT_Gateway"
  }
}
