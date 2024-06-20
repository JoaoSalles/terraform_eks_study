resource "aws_eip" "nat_gateway" {
  count = 2
  domain                    = "vpc"
  depends_on                = [aws_internet_gateway.new-igw]
}

resource "aws_nat_gateway" "terraform-lab-ngw" {
  count = 2
  allocation_id = aws_eip.nat_gateway[count.index].id
  subnet_id     = aws_subnet.subnets[count.index].id

  tags = {
    Name = "terraform-lab-ngw"
  }
  depends_on = [aws_eip.nat_gateway, aws_subnet.pvt-subnets]
}

resource "aws_route_table" "private-route-table" {
  count = 2
  vpc_id = aws_vpc.new-vpc.id
  tags = {
    Name = "private-terraform-lab-route-table-${count.index}"
  }
}

resource "aws_route" "nat-ngw-route" {
  count = 2
  route_table_id         = aws_route_table.private-route-table[count.index].id
  nat_gateway_id         = aws_nat_gateway.terraform-lab-ngw[count.index].id
  destination_cidr_block = "0.0.0.0/0"
}


resource "aws_route_table_association" "private-route-1-association" {
  count = 2
  route_table_id = aws_route_table.private-route-table[count.index].id
  subnet_id      = aws_subnet.pvt-subnets[count.index].id
}