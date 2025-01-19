#output for vpc
output "aws_vpc" {
  value = aws_vpc.base.id
}
# output for public subnet
output "aws_public" {
  value = aws_subnet.public[*].id
}
# web security id
output "web_security_group" {
    value = aws_security_group.web.id
}
# app security id
output "app_security_group" {
    value = aws_security_group.app.id
}
# db security id
output "db_security_group" {
    value = aws_security_group.db.id
}