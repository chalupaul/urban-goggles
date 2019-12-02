resource "aws_vpc" "default" {
  cidr_block          = "${var.cidr}"
  enable_dns_support  = true
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}
resource "aws_subnet" "main" {
  count = "${length(var.az-subnet-mapping)}"

  cidr_block              = "${lookup(var.az-subnet-mapping[count.index], "cidr")}"
  vpc_id                  = "${aws_vpc.default.id}"
  map_public_ip_on_launch = "${lookup(var.az-subnet-mapping[count.index], "isPublic")}"
  availability_zone       = "${lookup(var.az-subnet-mapping[count.index], "az")}"

  tags = {
    Name = "${lookup(var.az-subnet-mapping[count.index], "name")}"
  }
}
