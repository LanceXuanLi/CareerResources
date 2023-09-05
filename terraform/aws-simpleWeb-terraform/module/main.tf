resource "aws_security_group" "hello-world" {
  name        = "hello-world-sg"
  description = "Security group for hello-world"

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
    cidr_blocks = ["0.0.0.0/0"] # Limit SSH access to your IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_instance" "hello-world" {
  ami           = "ami-0373aa64534d82bf6" # Specify the hello-world-compatible AMI ID
  instance_type = "t2.micro"              # Change to your desired instance type
  security_groups = [aws_security_group.hello-world.name]

  tags = {
    Name = "hello-worldInstance"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum -y update
              yum -y install httpd
              systemctl start httpd
              systemctl enable httpd
              
              # Configure Apache to listen on port 8080
              echo 'Listen 8080' >> /etc/httpd/conf/httpd.conf
              
              # Create a simple HTML page with "Hello, World!"
              echo '<html><body><h1>Hello, World!</h1></body></html>' > /var/www/html/index.html
              
              # Restart Apache to apply the configuration changes
              systemctl restart httpd
              EOF
}