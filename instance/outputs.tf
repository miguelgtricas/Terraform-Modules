output "public_ip" {
    value = aws_instance.instance.public_ip
}

output "instance_id" {
    value = aws_instance.instance.id
}

output "private_dns" {
    value = aws_instance.instance.private_dns
}