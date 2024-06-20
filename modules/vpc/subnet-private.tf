resource "aws_subnet" "pvt-subnets" {
  count = var.availability_zones
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id = aws_vpc.new-vpc.id
  cidr_block = "10.0.${count.index + 2}.0/24"
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.prefix}-private-subnet-${count.index}"
  }
}
