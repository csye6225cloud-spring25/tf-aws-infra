resource "aws_subnet" "private_subnets" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value
  availability_zone = var.availability_zones[index(keys(var.private_subnets), each.key) % length(var.availability_zones)]
  tags = {
    Name      = each.key
    Terraform = "true"
  }
}

resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value
  availability_zone       = var.availability_zone1[index(keys(var.public_subnets), each.key) % length(var.availability_zones)]
  map_public_ip_on_launch = true
  tags = {
    Name      = each.key
    Terraform = "true"
  }
}
