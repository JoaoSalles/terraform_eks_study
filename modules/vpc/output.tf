output "vpc_id" {
  value = aws_vpc.new-vpc.id
}

output "subnet_ids" {
  value = aws_subnet.subnets.*.id
}

output "pvt-subnets" {
  value = aws_subnet.pvt-subnets.*.id
}