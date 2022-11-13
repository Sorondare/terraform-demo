output "ssh_command" {
  value = "ssh -i ~/.ssh/aws_id_rsa ec2-user@${aws_eip.nginx_server_eip.public_dns}"
}