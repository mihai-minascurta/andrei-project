# 1. Main VPC
resource "aws_vpc" "andrei_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Andrei-VPC"
  }
}

# 2. Public Subnet (For Web Servers)
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.andrei_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a" # e.g., eu-central-1a
  map_public_ip_on_launch = true # Automatically give servers a public IP

  tags = {
    Name = "Andrei-Public-Subnet"
  }
}

# 3. Private Subnet (for DB)
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.andrei_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.aws_region}b" # e.g., eu-central-1b (Different data center for backup)

  tags = {
    Name = "Andrei-Private-Subnet"
  }
}

# 4. Internet Gateway (the door for our VPC) GATEWAY FOR PUBLIC INTERNET

resource "aws_internet_gateway" "andrei_igw" {
  vpc_id = aws_vpc.andrei_vpc.id

  tags = {
    Name = "Andrei-IGW"
  }
}

# 5. Route Table (Any 0.0.0.0/0 ip [the internet] is obligated to go through Internet Gatway)

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.andrei_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.andrei_igw.id
  }

  tags = {
    Name = "Andrei-Public-RouteTable"
  }

}

# 6. Connect Public Subnet with Route table

resource "aws_route_table_association" "public_assoc" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# 7. We need an Elastic IP ( Permanent IP Adrees ) for DB -> Internet communication

resource "awp_eip" "nat_eip" {
  domain = "vpc"
}

# 8. NAT GATEWAY ( DB -> Internet is allowed , but DB <-- Internet is not allowed) GATEWAY FOR PRIVATE INTERNET

resource "aws_nat_gateway" "andrei_nat" {
  allocation_id = aws_eip.nat_eip.id # That elastic IP
  subnet_id = aws_subnet.public_subnet.id #Public subnet is connected with the Internet GateWay, so this is the line that make DB-->Internet to be allowed

  tags = {
    Name = "Andrei-NAT-Gateway"
  }
}

# 9. Route Table

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.andrei_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.andrei_nat.id 
  }

  tags = {
    Name = "Andrei-Private-RouteTable"
  }
} 

# 10. Connecting Route Table with Private Subnet

resource "aws_route_table_association" "private_assoc" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}
