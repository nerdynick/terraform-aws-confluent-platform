output "instances" {
    value = module.my_instance.instances
}

output "dns_records" {
    value = module.my_instance.dns_records
}

output "security_group" {
    value = module.my_sec_group.security_group
}