provider "aws" {
  region     = "${var.region}"  # Specify the AWS region using the value from the input variable "region"
  access_key = "${var.access_key}"  # Specify the AWS access key using the value from the input variable "access_key"
  secret_key = "${var.secret_key}"  # Specify the AWS secret access key using the value from the input variable "secret_key"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"  # Define the CIDR block for the VPC
  tags = {
    Name = "MyVPC"  # Assign a tag to the VPC with the name "MyVPC"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id                  = "${aws_vpc.main.id}"  # Associate the subnet with the VPC using its ID
  cidr_block              = "10.0.1.0/24"  # Define the CIDR block for the subnet
  map_public_ip_on_launch = "true"  # Automatically assign a public IP to instances launched in this subnet
  availability_zone       = "eu-west-2a"  # Specify the availability zone for the subnet
  tags = {
    Name = "PublicSubnet"  # Assign a tag to the subnet with the name "PublicSubnet"
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id                  = "${aws_vpc.main.id}"  # Associate the subnet with the VPC using its ID
  cidr_block              = "10.0.2.0/24"  # Define the CIDR block for the subnet
  availability_zone       = "eu-west-2a"  # Specify the availability zone for the subnet
  tags = {
    Name = "Private Subnet"  # Assign a tag to the subnet with the name "Private Subnet"
  }
}

resource "aws_internet_gateway" "MyIGW" {
  vpc_id = "${aws_vpc.main.id}"  # Associate the internet gateway with the VPC using its ID
  tags = {
    Name = "MyInternetGateway"  # Assign a tag to the internet gateway with the name "MyInternetGateway"
  }
}

resource "aws_route_table" "publicrt" {
  vpc_id = "${aws_vpc.main.id}"  # Associate the route table with the VPC using its ID

  route {
    cidr_block = "0.0.0.0/0"  # Define the destination CIDR block for the default route as all IP addresses
    gateway_id = "${aws_internet_gateway.MyIGW.id}"  # Specify the internet gateway ID as the target for the default route
  }

  tags = {
    Name = "PublicRouteTable"  # Assign a tag to the route table with the name "PublicRouteTable"
  }
}

resource "aws_route_table" "privatert" {
  vpc_id = "${aws_vpc.main.id}"  # Associate the route table with the VPC using its ID

  tags = {
    Name = "PrivateRouteTable"  # Assign a tag to the route table with the name "PrivateRouteTable"
  }
}

resource "aws_route_table_association" "public-association" {
  subnet_id        = "${aws_subnet.public-subnet.id}"  # Associate the public subnet with the public route table using their IDs
  route_table_id   = "${aws_route_table.publicrt.id}"
}

resource "aws_route_table_association" "private-association"{
    subnet_id        = "${aws_subnet.private-subnet.id}"  # Associate the private subnet with the private route table using their IDs
    route_table_id  = "${aws_route_table.privatert.id}"
}

