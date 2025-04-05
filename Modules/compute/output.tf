output "server_instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.nginx_server.id 
}

output "server_instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.nginx_server.public_ip
}