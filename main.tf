resource "aws_security_group" "sg" {
  name        = "newsletter-app-sg"
  description = "Allow HTTP and SSH inbound"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "newsletter-app-sg"
  }
}

data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "newsletter" {
  ami                    = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux2.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]

  user_data = <<-EOF
    #!/bin/bash
    set -e
    yum update -y
    amazon-linux-extras install docker -y
    systemctl enable docker
    systemctl start docker
    docker pull ${var.docker_image}
    docker run -d --name newsletter-app -p 80:3000 --restart unless-stopped ${var.docker_image}
    EOF

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "newsletter-app-instance"
  }
}

output "instance_public_ip" {
  value = aws_instance.newsletter.public_ip
}

output "app_url" {
  value = "http://${aws_instance.newsletter.public_ip}"
}
