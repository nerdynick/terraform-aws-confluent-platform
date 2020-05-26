output "instances" {
    value = aws_instance.instance
}

output "dns_records" {
    value = aws_route53_record.dns_record
}