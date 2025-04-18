# provider "aws" {
#   region = "us-east-1"
# }

module "vpc" {
  source = "./Modules/vpc"
  my_ip  = "0.0.0.0/0"
}

module "compute" {
  source         = "./Modules/compute"
  # instance_type  = "t2.micro" 
  # instance_count = 1 
  key_name       = "your-key-name"
  vpc_id         = module.vpc.vpc_id
  # subnet_id      = module.vpc.public_subnet_id 
  public_subnet_id = module.vpc.public_subnet_id
  security_group_id = module.vpc.security_group_id
}
# #create a route 53 hosted zone
# resource "aws_route53_zone" "public" {
#   name = var.route53_zone_name
#   }

# #create a route 53 hosted zone
data "aws_route53_zone" "main" {
  name         = "tunechi.sa.com."
  private_zone = false
  
}

# create a route 53 A record
resource "aws_route53_record" "nginx_record" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "www"
  type    = "A"
  ttl     = 300
  records = [module.compute.server_instance_public_ip]

}
