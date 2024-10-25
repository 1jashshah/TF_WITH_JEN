provider "aws" {
  region = var.region
}

resource "aws_instance" "my-instance" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "${terraform.workspace}-ec2-instance"
  }
}

output "instance_id" {
  value = aws_instance.my-instance.id
}

output "instance_public_ip" {
  value = aws_instance.my-instance.public_ip
}
