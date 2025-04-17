variable "region" {
  description = "The AWS region to deploy the resources."
  type        = string
  default     = "us-east-1"
  
}
variable "route53_zone_name" {
  description = "The name of the Route 53 hosted zone."
  type        = string
  default     = "tunechi.sa.com"
}

variable "nginx_record_name" {
  description = "The name of the Route 53 A record."
  type        = string
  default     = "nginx"
  
}
