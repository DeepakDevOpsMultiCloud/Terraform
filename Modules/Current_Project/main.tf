module "vpc" {
  source          = "./modules/vpc/"
  cidr            = var.cidr
  public          = var.public
  private         = var.private
  az              = var.az
  address         = var.address
  bastionsg       = var.bastionsg
  localip         = var.localip
  private_host_sg = var.private_host_sg
  bastionip       = var.bastionip
  ami             = var.ami
  instance_type   = var.instance_type
  bastion_key     = var.bastion_key
}