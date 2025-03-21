variable "cidr" {
  type        = string
  description = "This is about vpc CIDR"
  default     = ""
}


variable "public" {
  type        = list(string)
  description = "This is all about public subnets"
  default     = []
}


variable "private" {
  type        = list(string)
  description = "This is all about private subnets"
  default     = []
}

variable "address" {
  type        = string
  description = "This is all about Addresses range"
  default     = ""
}

variable "bastionsg" {
  type        = string
  description = "this is about the name of bastion name"
  default     = ""
}

variable "localip" {
  type        = string
  description = "the ip address of the connecting local machine"
  default     = ""
}

variable "private_host_sg" {
  type        = string
  description = "this is about the name of private host security group name"
  default     = ""
}

variable "bastionip" {
  type        = string
  description = "the ip address of the bastion_EC2"
  default     = ""
}

variable "ami" {
  type        = string
  description = "The Amazon Machine Image"
  default     = ""
}


variable "instance_type" {
  type        = string
  description = "The Size needed for the machine"
  default     = ""
}


variable "bastion_key" {
  type        = string
  description = "The SSH key needed to login into the machine"
  default     = ""
}

variable "az" {
  type        = list(string)
  description = "The AZ's"
  default     = []
}