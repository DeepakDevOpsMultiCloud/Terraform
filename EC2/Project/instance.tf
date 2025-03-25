resource "aws_instance" "web" {
  ami = "ami-0e86e20dae9224db8"
  instance_type               = "t2.micro"
  key_name                    = "keyforall"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public[0].id
  vpc_security_group_ids      = [aws_security_group.web.id]
}
  