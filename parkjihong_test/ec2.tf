resource "aws_instance" "bastion" {
  ami                    = var.bastion_image_id == "" ? data.aws_ami.ubuntu.id : var.bastion_image_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.bastion.id]
  subnet_id              = aws_subnet.pub2a.id
  key_name               = aws_key_pair.mykey.key_name

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = var.bastion_ec2
  }
}

#private 2a 11
resource "aws_instance" "masternode" {
  ami                    = var.bastion_image_id == "" ? data.aws_ami.ubuntu.id : var.bastion_image_id
  instance_type          = "t3.medium"
  vpc_security_group_ids = [aws_security_group.bastion.id]
  subnet_id              = aws_subnet.pri2a11.id
  key_name               = aws_key_pair.mykey.key_name

  tags = {
    Name = var.masternode
  }
}

#private 2a 12
resource "aws_instance" "workernode1" {
  ami                    = var.bastion_image_id == "" ? data.aws_ami.ubuntu.id : var.bastion_image_id
  instance_type          = "t3.medium"
  vpc_security_group_ids = [aws_security_group.bastion.id]
  subnet_id              = aws_subnet.pri2a12.id
  key_name               = aws_key_pair.mykey.key_name

  tags = {
    Name = var.workernode1
  }
}

#private 2c 22
resource "aws_instance" "workernode2" {
  ami                    = var.bastion_image_id == "" ? data.aws_ami.ubuntu.id : var.bastion_image_id
  instance_type          = "t3.medium"
  vpc_security_group_ids = [aws_security_group.bastion.id]
  subnet_id              = aws_subnet.pri2c21.id
  key_name               = aws_key_pair.mykey.key_name

  tags = {
    Name = var.workernode2
  }
}

##aws_image_ubuntu
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]

}