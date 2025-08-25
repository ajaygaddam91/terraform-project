variable "ami" {
  type    = string
  default = "ami-0360c520857e3138f"
}
variable "instance_type" {
  type    = string
  default = "t3.micro"
}
variable "aws_vpc" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "aws_subnet" {
  type    = list(string)
  default = ["10.0.0.0/24"]
}
variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}
variable "public_ip" {
  type    = bool
  default = true
}

variable "security_group_name" {
  type    = string
  default = "demo_security_group"
}
variable "security_ingress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  ipv6_cidr_blocks = list(string) }))
  default = [
    {
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      from_port        = 8080
      to_port          = 8080
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  ]
}
variable "security_config" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = number
    cidr_blocks = list(string)
  ipv6_cidr_blocks = list(string) }))
  default = [{
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]

  }]

}

variable "route_cidr" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
variable "tags" {
  type = map(any)
  default = {
    "vpc_name"         = "demo_vpc"
    "subnet_name"      = "demo_subnet"
    "security_group"   = "demo_security_group"
    "gateway_name"     = "demo_gw"
    "route_table_name" = "demo_route_table"
    "instance_vm"      = "demo_vm"
    "demo_key_name"    = "demo"
  }

}
variable "volume_size" {
  type    = number
  default = 8
}

variable "remote" {
  type = map(any)
  default = {
    "remote_type"        = "ssh"
    #"remote_user"        = "ubuntu"
   # "remote_private_key" = "./demo"
  }
}