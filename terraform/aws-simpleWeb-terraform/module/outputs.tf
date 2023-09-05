output "website_ip" {
  value = aws_instance.hello-world.public_ip
}