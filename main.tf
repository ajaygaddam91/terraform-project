#Creating Vnet
resource "aws_vpc" "demo_vpc" {
  cidr_block = var.aws_vpc[0]
  tags = {
    Name = var.tags["vpc_name"]
  }
}

#Creating subnet
resource "aws_subnet" "demo_subnet" {
  vpc_id                  = aws_vpc.demo_vpc.id
  cidr_block              = var.aws_subnet[0]
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = var.public_ip
  tags = {
    Name = var.tags["subnet_name"]
  }
}
#Creating Security group
resource "aws_security_group" "demo_security" {
  vpc_id = aws_vpc.demo_vpc.id
  name   = var.security_group_name

  dynamic "ingress" {
    for_each = var.security_ingress
    content {
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      cidr_blocks      = ingress.value.cidr_blocks
      ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks
    }
  }
  dynamic "egress" {
    for_each = var.security_config
    content {
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      protocol         = egress.value.protocol
      cidr_blocks      = egress.value.cidr_blocks
      ipv6_cidr_blocks = egress.value.ipv6_cidr_blocks
    }
  }
  tags = {
    Name = var.tags["security_group"]
  }
}

#Creating Internet Gateway
resource "aws_internet_gateway" "demo_gw" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = var.tags["gateway_name"]
  }
}

#Creating route table
resource "aws_route_table" "demo_route" {
  vpc_id = aws_vpc.demo_vpc.id
  route {
    cidr_block = var.route_cidr[0]
    gateway_id = aws_internet_gateway.demo_gw.id
  }
  tags = {
    Name = var.tags["route_table_name"]
  }
}

#Creating route table association
resource "aws_route_table_association" "demo_route_association" {
  subnet_id      = aws_subnet.demo_subnet.id
  route_table_id = aws_route_table.demo_route.id

}
resource "aws_key_pair" "demo" {
  key_name   = "demo"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzzqTA4utPXgRozVbL5xeutVz43Nt44CBz/7V1lLDtD6fsYYpOyK70SpyR62UcEeVYH6XnEIQ/G2mx1slD1Vv3l+LUmQoua/25qAQzD7YKtTVWCgUMOr+t+P/aTDKZS/oSE5APaBw47wH8FvQgjc0mEob+KznTaXcTZJFjHTy9ijuI0BFGwpc5ZBZGez3yfm+nARx+1g25Fvscu1+t4stHLCQQfdgZWOXMQ4bjAOHC2is5pMjTSsYBHkOTQTWI/8m5PsjDw3fArAUcZRmZOZIDZ7JfdrTYAKp2wHjpVspLyntQM8ypZejvzfKrFUFiKR7Y+TRUEfhU0LnI3cKOXIhiJkaTAUhn/md235No6wJFq0nX1NhTi/bj3Vkee2MYHiBqcOprno2X4rDgD+hpD0Ul+JxhqO5eEpoKBsajAa+RwwqKpznjCOhYLVxmD3APS+3K3DqBpZHO2uoorutEXCjZdSY8kiUcdKPhwyvF/UTKZyHBRqFolUlSzW8vF52GQfc= ajaygaddam@AJAY"
  tags = {
    Name = var.tags["demo_key_name"]
  }
}
resource "aws_instance" "demo_vm" {
  key_name               = var.tags["demo_key_name"]
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.demo_subnet.id
  vpc_security_group_ids = [aws_security_group.demo_security.id]
  root_block_device {
    volume_size = var.volume_size
  }
  tags = {
    Name = var.tags["instance_vm"]
  }
  provisioner "remote-exec" {
    script = "install.sh"
    connection {
      type        = var.remote["remote_type"]
      host        = aws_instance.demo_vm.public_ip
      user        = var.remote["remote_user"]
      private_key = file(var.remote["remote_private_key"])
    }
  }

}



