provider "aws" {
  region = "us-east-1"
}

variable "instances_number" {
  default = "2"
}

variable "vpc" {
  default = "vpc-067798a4183535af0"
}

#### Ec2 eith EBS ###

module "ec2" {
  source = "./modules"
  

  instance_count = var.instances_number

  name                        = "apache-ec2"
  ami                         = "ami-0533f2ba8a1995cf9"
  instance_type               = "t2.micro"
  subnet_ids                  = ["subnet-090a68ff58f29c7ee", "subnet-0457cd4826368f208"]
  vpc_security_group_ids      = ["sg-094125cb060d3e3f6"]
  associate_public_ip_address = true
  key_name                    = "demo"
  user_data                   = "${file("apache-install.sh")}"


}

resource "aws_volume_attachment" "ebs-attach" {
  count = var.instances_number

  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs[count.index].id
  instance_id = module.ec2.id[count.index]
}

resource "aws_ebs_volume" "ebs" {
  count = var.instances_number

  availability_zone = module.ec2.availability_zone[count.index]
  size              = 10
}
