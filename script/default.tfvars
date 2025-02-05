aws_vpc = {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "Ntier"
    Env  = "Devlopment"
  }

}
aws_public = [{
  cidr_block = "192.168.0.0/24"
  az         = "us-east-1a"
  tags = {
    Name = "Web-1"
  }
  }, {
  cidr_block = "192.168.1.0/24"
  az         = "us-east-1b"
  tags = {
    Name = "Web-2"
  }
}]

aws_private = [{
  cidr_block = "192.168.2.0/24"
  az         = "us-east-1a"
  tags = {
    Name = "App-1"
  }
  }, {
  cidr_block = "192.168.3.0/24"
  az         = "us-east-1b"
  tags = {
    Name = "App-2"
  }
  }, {
  cidr_block = "192.168.4.0/24"
  az         = "us-east-1a"
  tags = {
    Name = "Db-1"
  }
  }, {
  cidr_block = "192.168.5.0/24"
  az         = "us-east-1b"
  tags = {
    Name = "Db-2"
  }
}]


web_security_group = {
  name        = "Web"
  description = "Web-security-grp"
  inbound_rules = [{
    port        = 22
    protocol    = "tcp"
    source      = "0.0.0.0/0"
    description = "open ssh"
    }, {
    port        = 80
    protocol    = "tcp"
    source      = "0.0.0.0/0"
    description = "open http"
    }, {
    port        = 443
    protocol    = "tcp"
    source      = "0.0.0.0/0"
    description = "open https"
  }]
}

app_security_group = {
  name        = "App"
  description = "App-security-grp"
  inbound_rules = [{
    port        = 8000
    protocol    = "tcp"
    source      = "0.0.0.0/0"
    description = "open 8000 port"
  }]
}

db_security_group = {
  name        = "Db"
  description = "Db-security-grp"
  inbound_rules = [{
    port        = 3306
    protocol    = "tcp"
    source      = "0.0.0.0/0"
    description = "open 3306 port"
  }]
}
