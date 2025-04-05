# provider "aws" {
#   region = "us-east-1"
# }

module "vpc" {
  source = "./Modules/vpc"
  my_ip  = "0.0.0.0/0"
}

module "compute" {
  source         = "./Modules/compute"
  # instance_type  = "t2.micro" # Removed as it's not supported by the module
  # instance_count = 1 # Removed as it's not supported by the module
  key_name       = "your-key-name"
  vpc_id         = module.vpc.vpc_id
  # subnet_id      = module.vpc.public_subnet_id # Removed as it's not supported by the module
  public_subnet_id = module.vpc.public_subnet_id
  security_group_id = module.vpc.security_group_id
}
#create a route 53 hosted zone
resource "aws_route53_zone" "internal" {
  name = var.route53_zone_name
  }

# create a route 53 A record
resource "aws_route53_record" "nginx_record" {
  zone_id = aws_route53_zone.internal.zone_id
  name    = var.nginx_record_name
  type    = "A"
  ttl     = 300
  records = [module.compute.server_instance_public_ip]

}
