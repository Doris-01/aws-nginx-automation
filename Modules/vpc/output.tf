output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id

}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public-subnet.id
}

output "subnet_ip" {
  description = "The CIDR block of the public subnet"
  value       = aws_subnet.public-subnet.cidr_block
  
}

output "security_group_name" {
  value = aws_security_group.nginx_sg.name
}
output "security_group_id" {
  value = aws_security_group.nginx_sg.id
}