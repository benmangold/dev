terraform {
    backend "s3" {
        bucket = "dev-state-bucket"
        key = "globals/vpc/terraform.tfstate"
        region = "us-east-2"

        dynamodb_table = "benmangold-tf-state-lock-table"
        encrypt= "true"
    }
}

//

//

//

resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true

  tags = {
      Name = "dev"
  }
}

output "dev_vpc_id" {
    value = aws_vpc.dev.id
}

output "dev_vpc_arn" {
    value = aws_vpc.dev.arn
}

output "dev_vpc_ipv6" {
    value = aws_vpc.dev.ipv6_cidr_block
}

//

//

//

resource "aws_subnet" "dev" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = "10.0.1.0/24"

  map_public_ip_on_launch = true
  assign_ipv6_address_on_creation = false

  tags = {
    Name = "dev"
  }
}

output "dev_subnet_id" {
    value = aws_subnet.dev.id
}

output "dev_subnet_arn" {
    value = aws_subnet.dev.arn
}

output "dev_subnet_ip" {
    value = aws_subnet.dev.ipv6_cidr_block_association_id
}

//

//

//

# resource "aws_network_interface" "multi-ip" {
#   subnet_id   = aws_subnet.dev.id
#   private_ips = ["10.0.0.12", "10.0.1.11"]
# }

resource "aws_eip" "nat" {
  vpc                       = true
  tags = {
    Name = "dev"
  }
}

resource "aws_internet_gateway" "dev" {
  vpc_id = aws_vpc.dev.id
  tags = {
    Name = "dev"
  }
}

resource "aws_nat_gateway" "dev" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.dev.id

  tags = {
    Name = "dev NAT"
  }

    depends_on = [aws_internet_gateway.dev]
}

output "dev_nat_public_ip" {
    value = aws_nat_gateway.dev.public_ip
}

output "dev_nat_private_ip" {
    value = aws_nat_gateway.dev.private_ip
}

//

//

//

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "dev" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  subnet_id = aws_subnet.dev.id

  tags = {
    Name = "dev"
  }
}