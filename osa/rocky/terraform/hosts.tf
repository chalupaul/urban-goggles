resource "aws_instance" "infra1" {
  instance_type = "t2.micro"
  ami           = "${data.aws_ami.ubuntu1804.id}"
  key_name      = "${aws_key_pair.main.id}"
  tags = {
    Name = "infra1"
  }
  network_interface {
    network_interface_id = "${aws_network_interface.infra1_host.id}"
    device_index         = 0
  }
  network_interface {
    network_interface_id = "${aws_network_interface.infra1_ovs.id}"
    device_index         = 1
  }
}

resource "aws_network_interface" "infra1_host" {
  subnet_id       = "${module.networking.az-subnet-id-mapping["host"]}"
  security_groups = ["${aws_security_group.allow-ssh-and-egress.id}"]
}

resource "aws_network_interface" "infra1_ovs" {
  subnet_id       = "${module.networking.az-subnet-id-mapping["ovs"]}"
  security_groups = ["${aws_security_group.allow-ssh-and-egress.id}"]
}


resource "aws_instance" "infra2" {
  instance_type = "t2.micro"
  ami           = "${data.aws_ami.ubuntu1804.id}"
  key_name      = "${aws_key_pair.main.id}"
  tags = {
    Name = "infra2"
  }
  network_interface {
    network_interface_id = "${aws_network_interface.infra2_host.id}"
    device_index         = 0
  }
  network_interface {
    network_interface_id = "${aws_network_interface.infra2_ovs.id}"
    device_index         = 1
  }
}

resource "aws_network_interface" "infra2_host" {
  subnet_id       = "${module.networking.az-subnet-id-mapping["host"]}"
  security_groups = ["${aws_security_group.allow-ssh-and-egress.id}"]
}

resource "aws_network_interface" "infra2_ovs" {
  subnet_id       = "${module.networking.az-subnet-id-mapping["ovs"]}"
  security_groups = ["${aws_security_group.allow-ssh-and-egress.id}"]
}


resource "aws_instance" "infra3" {
  instance_type = "t2.micro"
  ami           = "${data.aws_ami.ubuntu1804.id}"
  key_name      = "${aws_key_pair.main.id}"
  tags = {
    Name = "infra3"
  }
  network_interface {
    network_interface_id = "${aws_network_interface.infra3_host.id}"
    device_index         = 0
  }
  network_interface {
    network_interface_id = "${aws_network_interface.infra3_ovs.id}"
    device_index         = 1
  }
}

resource "aws_network_interface" "infra3_host" {
  subnet_id       = "${module.networking.az-subnet-id-mapping["host"]}"
  security_groups = ["${aws_security_group.allow-ssh-and-egress.id}"]
}

resource "aws_network_interface" "infra3_ovs" {
  subnet_id       = "${module.networking.az-subnet-id-mapping["ovs"]}"
  security_groups = ["${aws_security_group.allow-ssh-and-egress.id}"]
}


resource "aws_instance" "network01" {
  instance_type = "t2.micro"
  ami           = "${data.aws_ami.ubuntu1804.id}"
  key_name      = "${aws_key_pair.main.id}"
  tags = {
    Name = "network01"
  }
  network_interface {
    network_interface_id = "${aws_network_interface.network01_host.id}"
    device_index         = 0
  }
  network_interface {
    network_interface_id = "${aws_network_interface.network01_ovs.id}"
    device_index         = 1
  }
}

resource "aws_network_interface" "network01_host" {
  subnet_id       = "${module.networking.az-subnet-id-mapping["host"]}"
  security_groups = ["${aws_security_group.allow-ssh-and-egress.id}"]
}

resource "aws_network_interface" "network01_ovs" {
  subnet_id       = "${module.networking.az-subnet-id-mapping["ovs"]}"
  security_groups = ["${aws_security_group.allow-ssh-and-egress.id}"]
}


resource "aws_instance" "network02" {
  instance_type = "t2.micro"
  ami           = "${data.aws_ami.ubuntu1804.id}"
  key_name      = "${aws_key_pair.main.id}"
  tags = {
    Name = "network01"
  }
  network_interface {
    network_interface_id = "${aws_network_interface.network02_host.id}"
    device_index         = 0
  }
  network_interface {
    network_interface_id = "${aws_network_interface.network02_ovs.id}"
    device_index         = 1
  }
}

resource "aws_network_interface" "network02_host" {
  subnet_id       = "${module.networking.az-subnet-id-mapping["host"]}"
  security_groups = ["${aws_security_group.allow-ssh-and-egress.id}"]
}

resource "aws_network_interface" "network02_ovs" {
  subnet_id       = "${module.networking.az-subnet-id-mapping["ovs"]}"
  security_groups = ["${aws_security_group.allow-ssh-and-egress.id}"]
}

resource "aws_instance" "compute01" {
  instance_type = "t2.micro"
  ami           = "${data.aws_ami.ubuntu1804.id}"
  key_name      = "${aws_key_pair.main.id}"
  tags = {
    Name = "network01"
  }
  network_interface {
    network_interface_id = "${aws_network_interface.compute01_host.id}"
    device_index         = 0
  }
  network_interface {
    network_interface_id = "${aws_network_interface.compute01_ovs.id}"
    device_index         = 1
  }
}

resource "aws_network_interface" "compute01_host" {
  subnet_id       = "${module.networking.az-subnet-id-mapping["host"]}"
  security_groups = ["${aws_security_group.allow-ssh-and-egress.id}"]
}

resource "aws_network_interface" "compute01_ovs" {
  subnet_id       = "${module.networking.az-subnet-id-mapping["ovs"]}"
  security_groups = ["${aws_security_group.allow-ssh-and-egress.id}"]
}

resource "null_resource" "osa_install" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    ids = "${join(",", aws_instance.infra*.id)}"
  }

  connection {
    host = "${element(aws_instance.infra01.public_ip, 0)}"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "./scripts/osa-install.sh ${join(" ", aws_instance.*.public_ip)}",
    ]
  }
}
