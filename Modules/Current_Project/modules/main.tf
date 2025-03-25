resource "aws_vpc" "my_vpc"{
      cidr_block = var.cidr
      tags = {
            Name = "first_vpc"
      }
}

resource "aws_subnet" "public"{
      count = length(var.public)
      vpc_id = aws_vpc.my_vpc.id
      availability_zone = var.az[count.index] 
      cidr_block = var.public[count.index]
}

resource "aws_subnet" "private"{
      count = length(var.private)
      vpc_id = aws_vpc.my_vpc.id
      cidr_block = var.private[count.index]
}

resource "aws_route_table" "public_rt"{
       vpc_id =  aws_vpc.my_vpc.id
        tags = {
            Name = "Public_rt"
        }
}

resource "aws_route_table" "private_rt"{
        vpc_id =  aws_vpc.my_vpc.id
        tags = {
            Name = "Private_rt"
        }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

}

resource "aws_eip" "elastic_ip"{
      domain = "vpc"
      tags = {
            Name = "elasticip"
      }
      
}

resource "aws_nat_gateway" "nat" {
  subnet_id     = aws_subnet.public[1].id
  allocation_id = aws_eip.elastic_ip.id
}

resource "aws_route" "public_routing"{
      route_table_id = aws_route_table.public_rt.id
      gateway_id = aws_internet_gateway.igw.id
      destination_cidr_block =  var.address

}


resource "aws_route" "private_routing"{
      route_table_id = aws_route_table.private_rt.id
      nat_gateway_id = aws_nat_gateway.nat.id
      destination_cidr_block = var.address
}

resource "aws_route_table_association" "as_pub" {
       count = length(aws_subnet.public)
      subnet_id      = aws_subnet.public[count.index].id
      route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "as_pri" {
       count = length(aws_subnet.private)
      subnet_id      = aws_subnet.private[count.index].id
      route_table_id = aws_route_table.private_rt.id
}

resource "aws_security_group" "bastion_sg"{
     name = var.bastionsg
     vpc_id = aws_vpc.my_vpc.id
     description = "This is security group of bastion host"
}

resource "aws_vpc_security_group_ingress_rule" "bastion_ingress" {
  security_group_id = aws_security_group.bastion_sg.id
  cidr_ipv4   = var.localip
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "bastion_egress" {
  security_group_id = aws_security_group.bastion_sg.id

  cidr_ipv4   = var.cidr
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_instance" "bastion_instance"{
   ami = var.ami
   instance_type = var.instance_type
   key_name = var.bastion_key
   vpc_security_group_ids = [aws_security_group.bastion_sg.id]
   subnet_id = aws_subnet.public[1].id
   tags = {
      Name = "Bastion_instance"
   }
}


resource "aws_security_group" "private_host_sg"{
     name = var.private_host_sg
     vpc_id = aws_vpc.my_vpc.id
     description = "This is security group of private host"
}

resource "aws_vpc_security_group_ingress_rule" "private_ingress" {
  security_group_id = aws_security_group.private_host_sg.id
  cidr_ipv4   = var.bastionip
  ip_protocol = -1
}