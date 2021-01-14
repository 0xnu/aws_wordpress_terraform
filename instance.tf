# INSTANCE and needed resources.

# public key to authorized access to host via ssh.
resource "aws_key_pair" "ssh_auth" {
  key_name = "key-wordpress"
  public_key = var.public_key
}

# security group + firewall inbound rules.
resource "aws_security_group" "wordpress-firewall" {
    name = "wordpress-firewall"
    description = "Allow HTTP/S traffic to the instance and SSH"

    ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    # This depends first on having they access key pair.
    depends_on = [aws_key_pair.ssh_auth]
}

# resource for instance
resource "aws_instance" "wordpress" {
 # instance definition
 ami = var.my_ami
 instance_type = var.my_instance
 # Security group with firewall rules.
 security_groups = [aws_security_group.wordpress-firewall.name]
 # Associate the key par created to access ssh.
 key_name = aws_key_pair.ssh_auth.key_name
 # instance depends on first having security group.
 depends_on = [aws_security_group.wordpress-firewall]

 # name of the app
 tags = {
   Name = var.app_name
 }
}

#------ [OUTPUTS]--------------
output "wordpress_public_ip" {
  value = aws_instance.wordpress.public_ip
}
output "wordpress_public_dns" {
  value = aws_instance.wordpress.public_dns
}
output "wordpress_private_ip" {
  value = aws_instance.wordpress.private_ip
}