output "security_group" {
    value = length(aws_security_group.my_security_group) > 0 ? aws_security_group.my_security_group[0].id : ""
}