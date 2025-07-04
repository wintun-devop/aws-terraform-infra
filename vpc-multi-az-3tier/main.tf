
/* define vpc */
resource "aws_vpc" "tf-test-vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "tf-test-pvc"
  }
}

resource "aws_internet_gateway" "igw-tf-test-vpc" {
  vpc_id = aws_vpc.tf-test-vpc.id
  tags = {
    Name = "igw-tf-test-pvc"
  }
}

resource "aws_subnet" "public-subnet-za-1" {
  vpc_id            = aws_vpc.tf-test-vpc.id
  cidr_block        = var.public-subnet-za-1
  availability_zone = var.az1
  tags = {
    Name = "public-subnet-za-1"
  }
}

resource "aws_subnet" "api-subnet-za-2" {
  vpc_id            = aws_vpc.tf-test-vpc.id
  cidr_block        = var.api-subnet-za-2
  availability_zone = var.az1
  tags = {
    Name = "api-subnet-za-2"
  }
}

resource "aws_subnet" "private-subnet-za-3" {
  vpc_id            = aws_vpc.tf-test-vpc.id
  cidr_block        = var.private-subnet-za-3
  availability_zone = var.az1
  tags = {
    Name = "private-subnet-za-3"
  }
}

resource "aws_subnet" "public-subnet-zb-4" {
  vpc_id            = aws_vpc.tf-test-vpc.id
  cidr_block        = var.public-subnet-zb-4
  availability_zone = var.az2
  tags = {
    Name = "public-subnet-zb-4"
  }
}

resource "aws_subnet" "api-subnet-zb-5" {
  vpc_id            = aws_vpc.tf-test-vpc.id
  cidr_block        = var.api-subnet-zb-5
  availability_zone = var.az2
  tags = {
    Name = "api-subnet-zb-5"
  }
}

resource "aws_subnet" "private-subnet-zb-6" {
  vpc_id            = aws_vpc.tf-test-vpc.id
  cidr_block        = var.private-subnet-zb-6
  availability_zone = var.az2
  tags = {
    Name = "private-subnet-zb-6"
  }
}

resource "aws_subnet" "public-subnet-zc-7" {
  vpc_id            = aws_vpc.tf-test-vpc.id
  cidr_block        = var.public-subnet-zc-7
  availability_zone = var.az3
  tags = {
    Name = "public-subnet-zc-7"
  }
}

resource "aws_subnet" "api-subnet-zc-8" {
  vpc_id            = aws_vpc.tf-test-vpc.id
  cidr_block        = var.api-subnet-zc-8
  availability_zone = var.az3
  tags = {
    Name = "api-subnet-zc-8"
  }
}

resource "aws_subnet" "private-subnet-zc-9" {
  vpc_id            = aws_vpc.tf-test-vpc.id
  cidr_block        = var.private-subnet-zc-9
  availability_zone = var.az3
  tags = {
    Name = "private-subnet-zc-9"
  }
}


/*  */
resource "aws_eip" "tf-test-vpc-nat-ip" {
  tags = {
    Name = "tf-test-vpc-nat-ip"
  }
}

resource "aws_nat_gateway" "nat-gw-tf-test-vpc" {
  allocation_id = aws_eip.tf-test-vpc-nat-ip.id
  subnet_id = aws_subnet.public-subnet-za-1.id

}

resource "aws_route_table" "tf-test-public-rt" {
  vpc_id = aws_vpc.tf-test-vpc.id
  /* route to internet   */
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-tf-test-vpc.id
  }
  tags = {
    Name = "tf-test-public-rt"
  }
}

resource "aws_route_table" "tf-test-api-rt" {
  vpc_id = aws_vpc.tf-test-vpc.id
  /* outbound access to internet */
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw-tf-test-vpc.id
  }
  tags = {
    Name = "tf-test-api-rt"
  }
}

resource "aws_route_table" "tf-test-private-rt" {
  vpc_id = aws_vpc.tf-test-vpc.id
  tags = {
    Name = "tf-test-private-rt"
  }
}

resource "aws_route_table_association" "public-association" {
  route_table_id = aws_route_table.tf-test-public-rt.id
  for_each = {
    subnet-1 = aws_subnet.public-subnet-za-1.id
    subnet-2 = aws_subnet.public-subnet-zb-4.id
    subnet-3 = aws_subnet.public-subnet-zc-7.id
  }
  subnet_id = each.value
}

resource "aws_route_table_association" "api-association" {
  route_table_id = aws_route_table.tf-test-api-rt.id
  for_each = {
    subnet-1 = aws_subnet.api-subnet-za-2.id
    subnet-2 = aws_subnet.api-subnet-zb-5.id
    subnet-3 = aws_subnet.api-subnet-zc-8.id
  }
  subnet_id = each.value
}

resource "aws_route_table_association" "private-association" {
  route_table_id = aws_route_table.tf-test-private-rt.id
  for_each = {
    subnet-1 = aws_subnet.private-subnet-za-3.id
    subnet-2 = aws_subnet.private-subnet-zb-6.id
    subnet-3 = aws_subnet.private-subnet-zc-9.id
  }
  subnet_id = each.value
}
