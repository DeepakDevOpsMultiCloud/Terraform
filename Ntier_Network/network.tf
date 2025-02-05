resource "aws_vpc" "ntier" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "ntier"
  }
}

resource "aws_subnet" "public_sn" {
  cidr_block = "10.0.0.0/24"
  vpc_id     = aws_vpc.ntier.id
  tags = {
    Name = "public_subnet"
  }
  depends_on = [aws_vpc.ntier]
}

resource "aws_subnet" "private_sn" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.ntier.id
  tags = {
    Name = "private_subnet"
  }
  depends_on = [aws_vpc.ntier]
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.ntier.id
  tags = {
    Name = "my_igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.ntier.id
  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.ntier.id
  tags = {
    Name = "private_rt"
  }
}


resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_sn.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.private_sn.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route" "igw_associate" {
  route_table_id = aws_route_table.public_rt.id
  gateway_id = aws_internet_gateway.my_igw.id
  destination_cidr_block = "0.0.0.0/0"
}