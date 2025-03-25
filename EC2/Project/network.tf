resource "aws_vpc" "base" {
  cidr_block = var.aws_vpc.cidr_block
  tags       = var.aws_vpc.tags

}

resource "aws_subnet" "public" {
  count             = length(var.aws_public)
  vpc_id            = aws_vpc.base.id
  cidr_block        = var.aws_public[count.index].cidr_block
  availability_zone = var.aws_public[count.index].az
  tags              = var.aws_public[count.index].tags
  depends_on        = [var.aws_vpc]
}

resource "aws_subnet" "private" {
  count             = length(var.aws_private)
  vpc_id            = aws_vpc.base.id
  cidr_block        = var.aws_private[count.index].cidr_block
  availability_zone = var.aws_private[count.index].az
  tags              = var.aws_private[count.index].tags
  depends_on        = [var.aws_vpc]
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "Ntier-gateway"
  }
  depends_on = [var.aws_vpc]
}

#creating an  public route table
resource "aws_route_table" "public_route" {
  #conditional statements
  count  = local.do_we_have_public_subnets ? 1 : 0
  vpc_id = aws_vpc.base.id

  tags = {
    Name = "Public"
  }

  depends_on = [aws_vpc.base]

}

#associating a public route table 
resource "aws_route_table_association" "public" {
  count = length(var.aws_public)
  route_table_id = aws_route_table.public_route[0].id
  subnet_id      = aws_subnet.public[count.index].id

  depends_on = [aws_vpc.base, aws_subnet.public]

}
#creating an private route table
resource "aws_route_table" "private_route" {
  #conditional statements
  count  = length(var.aws_private)
  vpc_id = aws_vpc.base.id

  tags = {
    Name = "Private"
  }

  depends_on = [aws_vpc.base]

}

# associating a private route table 
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  route_table_id = aws_route_table.private_route[0].id
  subnet_id      = aws_subnet.private[count.index].id


  depends_on = [aws_vpc.base, aws_subnet.public]

}


# add an routes to an intenet gateway
resource "aws_route" "intenet" {
  route_table_id         = aws_route_table.public_route[0].id
  destination_cidr_block = local.anywhere
  gateway_id             = aws_internet_gateway.gateway.id

}