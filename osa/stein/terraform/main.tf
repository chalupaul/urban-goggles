data "aws_ami" "ubuntu1804" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # 099720109477 is the id of the Canonical account
  # that releases the official AMIs.
  owners = ["099720109477"]
}

module "networking" {
  source = "./networking"
  cidr = "10.0.0.0/16"
  az-subnet-mapping = [
    {
      name      = "host"
      az        = "us-west-2a"
      cidr      = "10.0.1.0/24"
      isPublic  = true
    },
    {
      name      = "ovs"
      az        = "us-west-2a"
      cidr      = "10.0.2.0/24"
      isPublic  = false
    },
  ]
}

resource "aws_security_group" "allow-ssh-and-egress" {
  name = "main"

  description = "Allows SSH traffic into instances as well as all eggress."
  vpc_id      = "${module.networking.vpc-id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh-all"
  }
}
