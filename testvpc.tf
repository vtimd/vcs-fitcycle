# Define some variables used in resource creation
variable "keypair" {}
variable "vpcname" {}
variable "cidr" {}
variable "images" {
  type = "map"
  default = {
    web="ami-31126b4e"
    mgmt="ami-c1156cbe"
    db="ami-67156c18"
    dblb="ami-56146d29"
    app="ami-9e1c65e1"
    api="ami-751e670a"
  }
}
# Create resources for application deployment
resource "aws_vpc" "vpc_tuto" {
  cidr_block = "${var.cidr}/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.vpcname}"
  }
}
resource "aws_subnet" "public_subnet_us_west_1a" {
  vpc_id                  = "${aws_vpc.vpc_tuto.id}"
  cidr_block              = "${var.cidr}/20"
  map_public_ip_on_launch = true
  tags = {
    Name =  "Subnet main"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc_tuto.id}"
  tags {
        Name = "InternetGateway"
    }
}
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.vpc_tuto.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}
resource "aws_route_table_association" "public_subnet_us_west_1a_association" {
    subnet_id = "${aws_subnet.public_subnet_us_west_1a.id}"
    route_table_id = "${aws_vpc.vpc_tuto.main_route_table_id}"
}
resource "aws_security_group" "app_sec_group" {
    name = "app_sec_group"
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 8000
        to_port     = 8000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    vpc_id = "${aws_vpc.vpc_tuto.id}"
}
resource "aws_instance" "db1" {
  ami           = "${var.images["db"]}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public_subnet_us_west_1a.id}"
  vpc_security_group_ids = ["${aws_security_group.app_sec_group.id}"]
  key_name                    = "${var.keypair}"
  tags {
        App = "${var.vpcname}"
        Name = "db1-${var.vpcname}"
        Tier = "DB"
  }
}
resource "aws_instance" "db2" {
  ami           = "${var.images["db"]}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public_subnet_us_west_1a.id}"
  vpc_security_group_ids = ["${aws_security_group.app_sec_group.id}"]
  key_name                    = "${var.keypair}"
  tags {
        App = "${var.vpcname}"
        Name = "db2-${var.vpcname}"
        Tier = "DB"
  }
}
resource "aws_instance" "dblb" {
  ami           = "${var.images["dblb"]}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public_subnet_us_west_1a.id}"
  vpc_security_group_ids = ["${aws_security_group.app_sec_group.id}"]
  key_name                    = "${var.keypair}"
  tags {
        App = "${var.vpcname}"
        Name = "dblb-${var.vpcname}"
        Tier = "DBLB"
  }
}
resource "aws_instance" "app1" {
  ami           = "${var.images["app"]}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public_subnet_us_west_1a.id}"
  vpc_security_group_ids = ["${aws_security_group.app_sec_group.id}"]
  key_name                    = "${var.keypair}"
  tags {
        App = "${var.vpcname}"
        Name = "app1-${var.vpcname}"
        Tier = "App"
  }
}
resource "aws_instance" "app2" {
  ami           = "${var.images["app"]}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public_subnet_us_west_1a.id}"
  vpc_security_group_ids = ["${aws_security_group.app_sec_group.id}"]
  key_name                    = "${var.keypair}"
  tags {
        App = "${var.vpcname}"
        Name = "app2-${var.vpcname}"
        Tier = "App"
  }
}
resource "aws_instance" "app3" {
  ami           = "${var.images["app"]}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public_subnet_us_west_1a.id}"
  vpc_security_group_ids = ["${aws_security_group.app_sec_group.id}"]
  key_name                    = "${var.keypair}"
  tags {
        App = "${var.vpcname}"
        Name = "app3-${var.vpcname}"
        Tier = "App"
  }
}
resource "aws_instance" "web1" {
  ami           = "${var.images["web"]}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public_subnet_us_west_1a.id}"
  vpc_security_group_ids = ["${aws_security_group.app_sec_group.id}"]
  key_name                    = "${var.keypair}"
  tags {
        App = "${var.vpcname}"
        Name = "web1-${var.vpcname}"
        Tier = "Web"
  }
}
resource "aws_instance" "web2" {
  ami           = "${var.images["web"]}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public_subnet_us_west_1a.id}"
  vpc_security_group_ids = ["${aws_security_group.app_sec_group.id}"]
  key_name                    = "${var.keypair}"
  tags {
        App = "${var.vpcname}"
        Name = "web2-${var.vpcname}"
        Tier = "Web"
  }
}
resource "aws_instance" "api" {
  ami           = "${var.images["api"]}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public_subnet_us_west_1a.id}"
  vpc_security_group_ids = ["${aws_security_group.app_sec_group.id}"]
  key_name                    = "${var.keypair}"
  tags {
        App = "${var.vpcname}"
        Name = "api-${var.vpcname}"
        Tier = "API"
  }
}
resource "aws_instance" "mgmt" {
  ami           = "${var.images["mgmt"]}"
  instance_type = "t2.medium"
  subnet_id = "${aws_subnet.public_subnet_us_west_1a.id}"
  vpc_security_group_ids = ["${aws_security_group.app_sec_group.id}"]
  key_name                    = "${var.keypair}"
  tags {
        App = "${var.vpcname}"
        Name = "mgmt-${var.vpcname}"
        Tier = "Mgmt"
  }
}
