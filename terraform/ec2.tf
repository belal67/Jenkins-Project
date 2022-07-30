# Get latest Ubuntu Linux Focal Fossa 20.04 AMI
data "aws_ami" "ubuntu-linux-2004" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Create EC2 Instance
resource "aws_instance" "linux-server" {
  ami                         = data.aws_ami.ubuntu-linux-2004.id
  instance_type               = "t2.micro"
  subnet_id                   = module.network.private_1
  vpc_security_group_ids = [module.network.sg_allow_ssh_http]
  key_name                    = aws_key_pair.key_pair.key_name
  user_data                   = file("aws-user-data.sh")
  
  tags = {
    Name = "linux-vm"
  }
}

// bastion Ec2
resource "aws_instance" "bastionhost" {
  ami                         = data.aws_ami.ubuntu-linux-2004.id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = module.network.public_1
  key_name                    = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [ module.network.sg_allow_ssh]
  provisioner "local-exec" {
    command = "echo my ip is ${self.public_ip} "
  }
  tags = {
    Name = "bastionServer"
  }
}
