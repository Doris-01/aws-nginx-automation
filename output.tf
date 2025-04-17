output "nginx-public-url" {
    description = "The public URL of the NGINX server"
  value = "http://${module.compute.server_instance_public_ip}:8080"
}

# output "route53_name_servers" {
#   description = "The name servers assigned to the Route 53 hosted zone"
#   value       = aws_route53_zone.public.name_servers
# }

