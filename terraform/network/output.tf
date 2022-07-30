output "vpc" {
    value = aws_vpc.terraform-vpc.id
}
output "public_1" {
    value = aws_subnet.public1.id
}

output "public_2" {
    value = aws_subnet.public2.id
}

output "private_1" {
    value = aws_subnet.private1.id
}

output "private_2" {
    value = aws_subnet.private2.id
}

output "sg_allow_ssh" {
    value = aws_security_group.allow-ssh.id
}

output "sg_allow_ssh_3000" {
    value = aws_security_group.allow-22-3000.id
}
output "sg_allow_http" {
    value = aws_security_group.allow-http.id
}
output "sg_allow_ssh_http" {
    value = aws_security_group.allow-ssh-http.id
}
