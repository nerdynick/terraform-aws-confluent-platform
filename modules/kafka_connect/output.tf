output "instances" {
    value = module.my_instance.instances
}

output "dns_records" {
    value = module.my_instance.dns_records
}

output "security_group" {
    value = length(aws_security_group.my_security_group) > 0 ? aws_security_group.my_security_group[0].id : ""
}