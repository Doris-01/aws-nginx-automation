variable "security_group_name" {
    description = "The name of the security group."
    type        = string
    default     = "nginx-sg"
}
variable "security_group_id" {
  description = "Security group ID for EC2"
  type        = string
}

variable "public_subnet_id" {}
variable "vpc_id" {}
variable "key_name" {}
variable "ec2_instance" {
    default = "nginx-server"
}

variable "ssh_public_key" {
    description = "SSH public key for EC2 instance"
    type        = string
    default = "~/.ssh/id_rsa.pub" 
}

variable "ssh_private_key" {
    description = "SSH private key for EC2 instance"
    type        = string
    default = "~/.ssh/id_rsa" 
  
}
