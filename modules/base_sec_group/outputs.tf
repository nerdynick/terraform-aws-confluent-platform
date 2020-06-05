output "security_group" {
    value = length(aws_security_group.security_group) > 0 ? aws_security_group.security_group[0].id : ""
}