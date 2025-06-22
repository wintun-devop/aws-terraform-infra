
/* define vpc */
resource "aws_vpc" "tf-test-vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
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
    vpc_id = aws_vpc.tf-test-vpc.id
    cidr_block = var.public-subnet-za-1
    availability_zone = var.az1 
    tags = {
      Name ="public-subnet-za-1"
    }
}

resource "aws_subnet" "api-subnet-za-2" {
    vpc_id = aws_vpc.tf-test-vpc.id
    cidr_block = var.api-subnet-za-2
    availability_zone = var.az1
    tags = {
      Name = "api-subnet-za-2"
    }
}

resource "aws_subnet" "private-subnet-za-3" {
    vpc_id = aws_vpc.tf-test-vpc.id
    cidr_block = var.private-subnet-za-3
    availability_zone = var.az1
    tags = {
      Name = "private-subnet-za-3"
    }
}

resource "aws_route_table" "tf-test-public-rt" {
    vpc_id = aws_vpc.tf-test-vpc.id
    /* route to internet   */
    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw-tf-test-vpc.id
    }
    tags = {
      Name = "tf-test-public-rt"
    }
}

resource "aws_route_table" "tf-test-api-rt" {
  vpc_id = aws_vpc.tf-test-vpc.id
  tags = {
      Name = "tf-test-api-rt"
    }
}

resource "aws_route_table_association" "public-association" {
  route_table_id = aws_route_table.tf-test-public-rt.id
  for_each = {
    subnet-1=aws_subnet.public-subnet-za-1.id
  }
  subnet_id = each.value
}

resource "aws_route_table_association" "api-association" {
  route_table_id = aws_route_table.tf-test-api-rt.id
  for_each = {
    subnet-1=aws_subnet.api-subnet-za-2
  }
  subnet_id = each.value
}