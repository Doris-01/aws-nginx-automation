provider "aws" {
  region = "us-east-1"
}

#get linux ami id using ssm parameter endpoint
data "aws_ssm_parameter" "latest_amazon_linux" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

#create a key pair to access the ec2 instance
resource "aws_key_pair" "nginx_key" {
  key_name   = "nginx-key"
  public_key = file(var.ssh_public_key)
}
#create an ec2 instance to host the nginx server
resource "aws_instance" "nginx_server" {
    ami = data.aws_ssm_parameter.latest_amazon_linux.value
    instance_type = "t2.micro"
    key_name = aws_key_pair.nginx_key.key_name
    subnet_id = var.public_subnet_id
    vpc_security_group_ids = [var.security_group_id]
    associate_public_ip_address = true

    user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras enable python3.8
              yum clean metadata
              yum install -y python38 python38-pip
              ln -sf /usr/bin/python3.8 /usr/bin/python3
              ln -sf /usr/bin/pip3.8 /usr/bin/pip3
              pip3 install ansible
              EOF


    tags = {
        Name = "${var.ec2_instance}"
    }


# Provisioning the EC2 instance with Ansible

# Copy the file from local machine to EC2 instance
provisioner "file" {
  source      = "install_nginx.yaml"
  destination = "/home/ec2-user/install_nginx.yaml"  # Ensures it's copied to the home directory of the EC2 instance

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.ssh_private_key)
    host        = self.public_ip
  }
}

# Copy Ansible playbook to EC2 instance
provisioner "file" {
  source      = "${path.module}/../../install_nginx.yaml"
  destination = "/home/ec2-user/install_nginx.yaml"

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.ssh_private_key)
    host        = self.public_ip
  }
}

# Run the playbook on the EC2 instance
provisioner "remote-exec" {
  inline = [
    "sudo amazon-linux-extras enable ansible2",
    "sudo yum clean metadata",
    "sudo yum install -y ansible",
    "ansible-playbook /home/ec2-user/install_nginx.yaml"
  ]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.ssh_private_key)
    host        = self.public_ip
  }
}

}

# Output the public IP address of the EC2 instance
output "nginx_server_public_ip" {
  value = aws_instance.nginx_server.public_ip
}