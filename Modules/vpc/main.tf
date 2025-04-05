provider "aws" {
  region = var.region
}

#available zones in the region
data "aws_availability_zones" "available" {
  state = "available"
}
#create a vpc for the region
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}
#create a subnet for the vpc
resource "aws_subnet" "public-subnet" {
vpc_id = aws_vpc.main.id
  cidr_block = var.vpc_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = var.public_subnet
  }
}
# create a security group to allow http traffic but restrict ssh traffic
resource "aws_security_group" "nginx_sg" {  
    name        = var.security_group_name
    description = "Allow HTTP and restrict SSH"
    vpc_id      = aws_vpc.main.id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.my_ip]
        # replace with your public IP address
        # or use a variable to pass the IP address
        # e.g. cidr_blocks = [var.my_ip]
  
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      }
    tags = {
        Name = var.security_group_name
    }
}

# create an internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = var.igw
    }
}
    
# create a route table
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = var.route_table
    }
}
    
# create a route table association
resource "aws_route_table_association" "public_route_table_association" {
    subnet_id      = aws_subnet.public-subnet.id
    route_table_id = aws_route_table.public_route_table.id
}

# #create a route 53 hosted zone
# resource "aws_route53_zone" "internal" {
#   name = var.route53_zone_name
#   }

# # create a route 53 A record
# resource "aws_route53_record" "nginx_record" {
#   zone_id = aws_route53_zone.internal.zone_id
#   name    = var.nginx_record_name
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.nginx_server.public_ip]
# }
