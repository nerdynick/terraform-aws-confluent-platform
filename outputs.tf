output "zookeeper_instances" {
    value = module.cp-aws-zookeeper.instances
}
output "zookeeper_dns_records" {
    value = module.cp-aws-zookeeper.dns_records
}
output "zookeeper_security_group" {
    value = module.cp-aws-zookeeper.security_group
}

output "kafka_broker_instances" {
    value = module.cp-aws-kafka_broker.instances
}
output "kafka_broker_dns_records" {
    value = module.cp-aws-kafka_broker.dns_records
}
output "kafka_broker_security_group" {
    value = module.cp-aws-kafka_broker.security_group
}

output "kafka_connect_instances" {
    value = module.cp-aws-kafka_connect.instances
}
output "kafka_connect_dns_records" {
    value = module.cp-aws-kafka_connect.dns_records
}
output "kafka_connect_security_group" {
    value = module.cp-aws-kafka_connect.security_group
}

output "control_center_instances" {
    value = module.cp-aws-control_center.instances
}
output "control_center_dns_records" {
    value = module.cp-aws-control_center.dns_records
}
output "control_center_security_group" {
    value = module.cp-aws-control_center.security_group
}

output "ksql_instances" {
    value = module.cp-aws-ksql.instances
}
output "ksql_dns_records" {
    value = module.cp-aws-ksql.dns_records
}
output "ksql_security_group" {
    value = module.cp-aws-ksql.security_group
}

output "rest_proxy_instances" {
    value = module.cp-aws-rest_proxy.instances
}
output "rest_proxy_dns_records" {
    value = module.cp-aws-rest_proxy.dns_records
}
output "rest_proxy_security_group" {
    value = module.cp-aws-rest_proxy.security_group
}

output "schema_registry_instances" {
    value = module.cp-aws-schema_registry.instances
}
output "schema_registry_dns_records" {
    value = module.cp-aws-schema_registry.dns_records
}
output "schema_registry_security_group" {
    value = module.cp-aws-schema_registry.security_group
}

