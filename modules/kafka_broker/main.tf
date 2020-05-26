module "cp-aws-kafka_broker" {
    source = "../base_node"
    
    extra_template_vars = var.extra_template_vars
    
    servers = var.servers
    image_id = var.image_id
    instance_type = var.instance_type
    root_volume_size = var.root_volume_size
    key_pair = var.key_pair
    tags = var.tags
    subnet_id = var.subnet_id
    security_groups_ids = var.security_groups_ids
    dns_zone_id = var.dns_zone_id
    dns_ttl = var.dns_ttl
    name_template = var.name_template
    dns_template = var.dns_template
}