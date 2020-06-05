module "my_sec_group" {
    source = "../base_sec_group"
    
    component_name = "Kafka Connect"
    
    vpc_id = var.vpc_id
    enable_sg_creation = var.enable_sg_creation
    sg_name = var.sg_name
    port_external_range = var.port_external_range
    port_internal_range = var.port_internal_range
    external_access_security_group_ids = concat([
        var.control_center_sg_id
    ], var.external_access_security_group_ids)
    external_access_cidrs = var.external_access_cidrs
    tags = var.tags
}

locals {
    external_ports = distinct(flatten([
        for port_rng in var.port_external_range:
        range(port_rng.from, port_rng.to+1)
    ]))
}

module "my_lb" {
    source = "../base_lb"
    
    vpc_id = var.vpc_id
    subnets = var.subnet_ids
    tags = var.tags
    enable_lb_creation = var.enable_lb_creation ? (var.servers > 0) : false
    
    lb_name = var.lb_name
    lb_internal = var.lb_internal
    lb_idle_timeout = var.lb_idle_timeout
    security_groups_ids = concat(var.security_groups_ids, [module.my_sec_group.security_group])
    port_external_http = [
        for port in local.external_ports:
        port
        if contains(var.port_external_https, port) == false
    ]
    port_external_https = var.port_external_https
    port_external_https_certificate_arn = var.port_external_https_certificate_arn
    
    
    health_check = {
        path: "/"
        healthy_threshold: 3
        unhealthy_threshold: 3
        timeout: 6
        matcher: "200-299"
    }
}

module "my_instance" {
    source = "../base_node"
    
    extra_template_vars = var.extra_template_vars
    
    servers = var.servers
    image_id = var.image_id
    instance_type = var.instance_type
    root_volume_size = var.root_volume_size
    key_pair = var.key_pair
    tags = var.tags
    subnet_id = element(var.subnet_ids, 0)
    security_groups_ids = concat(var.security_groups_ids, [module.my_sec_group.security_group])
    dns_zone_id = var.dns_zone_id
    dns_ttl = var.dns_ttl
    name_template = var.name_template
    dns_template = var.dns_template
    enable_dns_creation = var.enable_dns_creation
    
    lb_target_groups = module.my_lb.target_group_arns
}