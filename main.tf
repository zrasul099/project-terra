

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/file.pub")
}
# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["592524167743"] # Canonical
# }



resource "aws_instance" "project-PubEC2" {
  ami                         = var.insAMI
  instance_type               = var.insType
  key_name                    = aws_key_pair.deployer.key_name
  subnet_id      = aws_subnet.public_subnet.id
  security_groups     = [aws_security_group.project-security-group.id]
  availability_zone           = "${var.region}a"
 
 
  associate_public_ip_address = true
   iam_instance_profile = aws_iam_instance_profile.role_profile.name
  user_data                   = filebase64("./web-script.sh")
  

  tags = {
    Name = "my-web-ec2"
  }
}


module "s3"{
  source = "./s3"
}


