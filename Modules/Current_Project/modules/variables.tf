variable "cidr"{
    type = string
    description = "This is about vpc CIDR"

}

variable "public"{
    type = list(string)
    description = "This is all about public subnets"

}


variable "private"{
    type = list(string)
    description = "This is all about private subnets"
}


variable "address"{
    type = string 
    description = "This is all about Addresses range"
}

variable "bastionsg" {
  type        = string
  description = "this is about the name of bastion security group name"
}

variable "localip" {
  type        = string
  description = "the ip address of the connecting local machine"
}

variable "private_host_sg" {
  type        = string
  description = "this is about the name of private host security group name"
}

variable "bastionip" {
  type        = string
  description = "the ip address of the bastion_EC2"
}

variable "ami" {
  type        = string
  description = "The Amazon Machine Image"
}

variable "instance_type" {
  type        = string
  description = "The Size needed for the machine"
}

variable "bastion_key" {
  type        = string
  description = "The SSH key needed to login into the machine"
  default = ""
}

variable "az"{
    type = list(string)
    description = "The AZ's"
}