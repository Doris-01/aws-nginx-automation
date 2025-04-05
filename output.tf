output "nginx-public-url" {
    description = "The public URL of the NGINX server"
  value = "http://${module.compute.server_instance_public_ip}:8080"
}
