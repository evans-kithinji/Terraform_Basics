output "vpc_id" {
    value = aws_vpc.main.id
}

output "public_subnet"{
     value = aws_subnet.public-subnet.id
}

output "private_subnet"{
     value = aws_subnet.private-subnet.id
}

##This output block defines an output variable named "private_subnet" that outputs the ID of the private subnet (aws_subnet.private-subnet.id).
##It can be used to display the ID of the private subnet after the infrastructure is created.

##Make sure to provide appropriate values for the variables var.region, var.access_key, and var.secret_key in order to configure the AWS provider correctly.
##Also, ensure that the CIDR blocks, availability zones, and tag names align with your desired infrastructure configuration.
