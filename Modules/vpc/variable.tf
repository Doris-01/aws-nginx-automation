variable "region" {
  description = "The AWS region to deploy the VPC in."
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {    
  description = "The name of the VPC."
  type        = string
  default     = "nginx-vpc"
  
}

variable "vpc_cidr" { 
    description = "The CIDR block for the VPC."
    type        = string
    default     = "10.0.0.0/16"
  }

variable "public_subnet" {
    description = "The CIDR block for the public subnet."
    type        = string
    default = "nginx-public-subnet"
}

variable "private_subnet" {
    description = "The CIDR block for the private subnet."
    type        = string
    default = "nginx-private-subnet"
}

variable "security_group_name" {
    description = "The security group for the VPC."
    type        = string
    default     = "nginx-sg"
}

variable "my_ip"{
  description = "The IP address of the user."
  type        = string
}

variable "igw" {    
    description = "The internet gateway for the VPC."
    type        = string
    default     = "nginx-igw"
}
variable "route_table" {
    description = "The route table for the VPC."
    type        = string
    default     = "nginx-route-table"
  
}

# variable "route53_zone_name" {
#   description = "The name of the Route 53 hosted zone."
#   type        = string
#   default     = "nginx-project.com"
# }

# variable "nginx_record_name" {
#   description = "The name of the Route 53 A record."
#   type        = string
#   default     = "nginx.project.com"
  
# }