
output "WebServer_instance_id" {
  value = aws_instance.My_WebServer.id
}

output "WebServer_public_ip_address" {
  value = aws_eip.my_ststic_ip.public_ip
}

output "WebServer_sg_id" {
  value = aws_security_group.My_WebServer.id
}

output "WebServer_sg_arn" {
  value = aws_security_group.My_WebServer.arn
}
