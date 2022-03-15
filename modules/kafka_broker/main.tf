terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
      configuration_aliases = [aws.default, aws.dns]
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2.0"
    }
  }
}

locals {
   component_name = "Kafka Broker"
   component_short_name = "kfk"
}

module "my_sec_group" {
    source = "../base_sec_group"
    
    providers = {
        aws.default = aws.default
    }
    
    component_name = local.component_name
    
    vpc_id = var.vpc_id
    enable_sg_creation = var.enable_sg_creation
    sg_name = var.sg_name
    port_external_range = var.port_external_range
    port_internal_range = var.port_internal_range
    external_access_security_group_ids = concat([
        var.rest_proxy_sg_id,
        var.schema_registry_sg_id,
        var.control_center_sg_id
    ], var.kafka_connect_sg_ids, var.ksql_sg_ids, var.external_access_security_group_ids)
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
    
    extra_template_vars = merge({
        component_name = local.component_name
        component_short_name = local.component_short_name
    }, var.extra_template_vars)
    
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

    user_data_template = var.user_data_template
    user_data_template_vars = var.user_data_template_vars
    
    ebs_volumes = concat([
        {
            name:"data", 
            device_name:var.vol_data_device_name, 
            encrypted:false, 
            kms_key_id="", 
            size:var.vol_data_size, 
            type: var.vol_data_type == null ? (var.vol_data_size > 500 ? "st1" : "gp2") : var.vol_data_type, 
            tags:{}
        }
    ], var.extra_ebs_volumes)
}