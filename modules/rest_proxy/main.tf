provider "aws" {
    alias = "default"
}
provider "aws" {
    alias = "dns"
}

module "my_sec_group" {
    source = "../base_sec_group"
    
    providers = {
        aws.default = aws.default
    }
    
    component_name = "REST Proxy"
    
    vpc_id = var.vpc_id
    enable_sg_creation = var.enable_sg_creation
    sg_name = var.sg_name
    port_external_range = var.port_external_range
    port_internal_range = var.port_internal_range
    external_access_security_group_ids = var.external_access_security_group_ids
    external_access_cidrs = var.external_access_cidrs
    tags = var.tags

    monitoring_security_group_ids = var.monitoring_security_group_ids
    monitoring_cidrs = var.monitoring_cidrs
    prometheus_enabled = var.prometheus_enabled
    jolokia_enabled = var.jolokia_enabled
    prometheus_port = var.prometheus_port
    jolokia_port = var.jolokia_port
}

module "my_instance" {
    source = "../base_node"
    
    providers = {
        aws.default = aws.default
        aws.dns = aws.dns
    }
    
    extra_template_vars = var.extra_template_vars
    
    servers = var.servers
    image_id = var.image_id
    instance_type = var.instance_type
    root_volume_size = var.root_volume_size
    key_pair = var.key_pair
    tags = var.tags
    multi_az = var.multi_az
    subnet_ids = var.subnet_ids
    security_group_ids = concat(var.security_group_ids, [module.my_sec_group.security_group])
    dns_zone_id = var.dns_zone_id
    dns_ttl = var.dns_ttl
    name_template = var.name_template
    dns_template = var.dns_template
    enable_dns_creation = var.enable_dns_creation

    prometheus_enabled = var.prometheus_enabled
    jolokia_enabled = var.jolokia_enabled
    prometheus_port = var.prometheus_port
    jolokia_port = var.jolokia_port
}