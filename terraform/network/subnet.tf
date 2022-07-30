
resource "aws_subnet" "public1" {
    vpc_id     = aws_vpc.terraform-vpc.id
    cidr_block = var.cidr_public1
    availability_zone = "${var.region}a"
    map_public_ip_on_launch = true

    tags = {
    Name = "public1"
  }
}

resource "aws_subnet" "public2" {
    vpc_id     = aws_vpc.terraform-vpc.id
    cidr_block = var.cidr_public2
    availability_zone = "${var.region}b"
    map_public_ip_on_launch = true

    tags = {
    Name = "public2"
  }
}

resource "aws_subnet" "private1" {
    vpc_id     = aws_vpc.terraform-vpc.id
    cidr_block = var.cidr_private1
    availability_zone = "${var.region}a"

    tags = {
    Name = "private1"
    }
}

resource "aws_subnet" "private2" {
    vpc_id     = aws_vpc.terraform-vpc.id
    cidr_block = var.cidr_private2
    availability_zone = "${var.region}b"

    tags = {
    Name = "private2"
    }
}