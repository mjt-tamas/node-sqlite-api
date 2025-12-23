provider "aws" {
  region = "eu-north-1"
}

# 1. Automatically find the latest Ubuntu 24.04 AMI for Stockholm
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical's AWS ID
}

# 2. Security Group (Firewall)
resource "aws_security_group" "api_sg" {
  name        = "node_api_sg"
  description = "Allow SSH and API traffic"

  # SSH Access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  # API Access
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

	# Jenkins Access
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound traffic (allow the server to download Docker)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

	# Prometheus Dashboard
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

	# Grafana Dashboard
  ingress {
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 3. EC2 Instance
resource "aws_instance" "api_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  
  # Adjusted to match your terraform.pem file
  key_name      = "terraform" 

  vpc_security_group_ids = [aws_security_group.api_sg.id]

  # Userdata: Automated Docker installation on startup
  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ubuntu
              EOF

  tags = {
    Name = "Node-API-DevOps-Server"
  }
}

#4. Output the IP for SSH access
output "instance_public_ip" {
  value = aws_instance.api_server.public_ip
}