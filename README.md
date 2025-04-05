# aws-nginx-automation
PROJECT-using Terraform and Ansible for NGINX deployment

AWS NGINX Automation with Terraform and Ansible

Project Overview

This project automates the deployment of a basic NGINX server on AWS EC2 using Terraform for Infrastructure as Code (IaC) and Ansible for configuration management. The project includes the setup of a Route 53 hosted zone, an A record for the EC2 instance, and the addition of an SSL certificate via Let's Encrypt.

Project Features

Infrastructure as Code (IaC) using Terraform to:
Create an EC2 instance.
Set up a VPC and Security Group.
Create an A record in Route 53.
Configuration Management using Ansible to:
Install NGINX.
Configure NGINX with basic settings.
Install Certbot for obtaining an SSL certificate from Let’s Encrypt.
Security:
Allow HTTP (80) and HTTPS (443) traffic from anywhere.
Block SSH traffic from the world and only allow access from a specific IP (optional, can be configured in Terraform variables).
