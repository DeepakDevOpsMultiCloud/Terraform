cidr            = "10.0.0.0/16"
public          = ["10.0.0.0/24", "10.0.1.0/24"]
private         = ["10.0.2.0/24", "10.0.3.0/24"]
az              = ["us-east-1a", "us-east-1b"]
address         = "10.0.0.0/15"
bastionsg       = "bastion_EC2_sg"
localip         = "122.174.179.193/32"
private_host_sg = "eks_sg"
bastionip       = "0.0.0.0/0"
ami             = "ami-0e1bed4f06a3b463d"
instance_type   = "t2.medium"
bastion_key     = "bastion_key"