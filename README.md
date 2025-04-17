# AWS NGINX + Let's Encrypt Automation Project

This project automates the deployment of a secure NGINX web server on AWS using **Terraform** and **Ansible**. The setup includes provisioning EC2 instances, configuring NGINX, and obtaining a free SSL certificate from Let's Encrypt.

---

## 🔧 Technologies Used

- **Terraform** – Infrastructure as Code (IaC) for provisioning AWS resources
- **Ansible** – Configuration management and automated server setup
- **NGINX** – Web server to serve content
- **Let's Encrypt** – Free SSL certificates for HTTPS
- **Amazon Linux 2** – Lightweight, secure OS for EC2 instances

---

## 🧱 Project Structure
aws-nginx-automation/ ├── ansible/ │ ├── inventory.ini # Target EC2 instance IPs │ └── install-nginx.yaml # Ansible playbook for installing and configuring NGINX + SSL ├── terraform/ │ ├── main.tf # Root Terraform file │ ├── ec2_module/ # EC2 instance module │ └── vpc_module/ # VPC, Subnet, and Security Group module └── README.md

---

## ☁️ Infrastructure Overview

- **VPC Module**
  - Custom VPC, Public Subnet, Internet Gateway
  - Security Group allowing ports **22 (SSH)**, **80 (HTTP)**, and **443 (HTTPS)**

- **Compute Module**
  - Amazon Linux 2 EC2 instance (t2.micro)
  - Public IP assigned, SSH key pair added

---

## ⚙️ Setup Instructions

### 1. Clone the Repo

```bash
git clone https://github.com/Doris-01/aws-nginx-automation.git
cd aws-nginx-automation

2. Deploy Infrastructure (Terraform)
cd terraform
terraform init
terraform apply

3. Configure Server (Ansible)
Update the ansible/inventory.ini file with the EC2 public IP:

ini
[web_servers]
<ec2-public-ip> ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/your-key.pem
Run the playbook:
cd ../ansible
ansible-playbook -i inventory.ini install-nginx.yaml

🔒 SSL Certificate with Let's Encrypt
Certbot uses the webroot plugin to obtain and auto-configure HTTPS for www.tunechi.sa.com.

Auto-renewal is scheduled using a cron job:

cron
0 3 * * * /usr/bin/certbot renew --quiet

✅ Final Output
You should be able to access your secure NGINX server at:

https://www.tunechi.sa.com

With:

A valid SSL certificate

Basic HTML page: Welcome to Doris's Nginx server!

✍️ Author
Emeh Tochi Doris
📧 delorezdoris@gmail.com

