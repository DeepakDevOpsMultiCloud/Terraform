variable "aws_vpc" {
  type = object({
    cidr_block = string
    tags       = map(string)
  })
  description = "defining aws vpc"

}

variable "aws_public" {
  type = list(object({
    cidr_block = string
    az         = string
    tags       = map(string)
  }))
  description = "defining public subnet info"

}

variable "aws_private" {
  type = list(object({
    cidr_block = string
    az         = string
    tags       = map(string)
  }))
  description = "defining public subnet info"
}

variable "web_security_group" {
  type = object({
    name        = string
    description = string
    inbound_rules = list(object({
      protocol    = string
      source      = string
      port        = string
      description = string
    }))
  })

}

variable "app_security_group" {
  type = object({
    name        = string
    description = string
    inbound_rules = list(object({
      protocol    = string
      source      = string
      port        = number
      description = string
    }))
  })

}

variable "db_security_group" {
  type = object({
    name        = string
    description = string
    inbound_rules = list(object({
      protocol    = string
      source      = string
      port        = string
      description = string
    }))
  })

}
























































