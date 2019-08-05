output "public_sg_id" {
    description =   "The ID of Security Group to access cloud9"
    value       =   "${aws_security_group.public_sg.id}"
}

output "private_sg_id" {
    description =   "The ID of Security Group to private"
    value       =   "${aws_security_group.private_sg.id}"
}
