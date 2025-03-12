resource "aws_instance" "example" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  vpc_security_group_ids = ["sg-0ebe13a8a79866eed"]  
  subnet_id       ="subnet-07f0b07b1f0b03ff6"
  tags = {
    Name = "My_crazy_instance"
  }
}
