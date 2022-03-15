terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
      configuration_aliases = [aws.dns]
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2.0"
    }
  }
}
provider "aws" {
    alias = "dns"
}

module "cp-aws-zookeeper" {
    source = "./modules/zookeeper"
    
    providers = {
        aws = aws
        aws.dns = aws.dns
    }

    servers = var.zookeeper_servers
    image_id = var.zookeeper_image_id == "" ? var.image_id : var.zookeeper_image_id
    instance_type = var.zookeeper_instance_type
    root_volume_size = var.zookeeper_root_volume_size
    key_pair = var.zookeeper_key_pair == "" ? var.key_pair : var.zookeeper_key_pair
    tags = merge(var.default_tags, var.zookeeper_tags)
    subnet_ids = length(var.zookeeper_subnet_ids) > 0 ? var.zookeeper_subnet_ids : var.subnet_ids
    multi_az = var.multi_az && var.zookeeper_multi_az
    security_group_ids = length(var.zookeeper_security_group_ids) > 0 ? var.zookeeper_security_group_ids : var.security_group_ids
    dns_zone_id = var.zookeeper_dns_zone_id == "" ? var.dns_zone_id : var.zookeeper_dns_zone_id
    dns_ttl = var.zookeeper_dns_ttl
    name_template = var.zookeeper_name_template
    dns_template = var.zookeeper_dns_template
    sg_name = var.zookeeper_sg_name
    kafka_broker_sg_id = module.cp-aws-kafka_broker.security_group
    
    extra_template_vars = merge(var.zookeeper_extra_template_vars, var.extra_template_vars)
    user_data_template_vars = merge(var.zookeeper_user_data_template_vars, var.user_data_template_vars)
    user_data_template = var.zookeeper_user_data_template
    vpc_id = var.vpc_id
    enable_sg_creation = var.enable_sg_creation ? var.zookeeper_enable_sg_creation : false
    enable_dns_creation = var.enable_dns_creation && var.zookeeper_enable_dns_creation
    
    port_external_range = var.zookeeper_port_external_range
    port_internal_range = var.zookeeper_port_internal_range
    external_access_security_group_ids = var.zookeeper_external_access_security_group_ids
    external_access_cidrs = var.zookeeper_external_access_cidrs
    
    extra_ebs_volumes = var.zookeeper_extra_ebs_volumes
    vol_trans_log_size = var.zookeeper_vol_trans_log_size
    vol_trans_log_device_name = var.zookeeper_vol_trans_log_device_name
    vol_storage_size = var.zookeeper_vol_storage_size
    vol_storage_device_name = var.zookeeper_vol_storage_device_name

    monitoring_security_group_ids = var.monitoring_security_group_ids
    monitoring_cidrs = var.monitoring_cidrs
    prometheus_enabled = var.prometheus_enabled
    jolokia_enabled = var.jolokia_enabled
    prometheus_port = var.zookeeper_prometheus_port
    jolokia_port = var.zookeeper_jolokia_port
}

module "cp-aws-kafka_broker" {
    source = "./modules/kafka_broker"
    
    providers = {
        aws = aws
        aws.dns = aws.dns
    }

    servers = var.kafka_broker_servers
    image_id = var.kafka_broker_image_id == "" ? var.image_id : var.kafka_broker_image_id
    instance_type = var.kafka_broker_instance_type
    root_volume_size = var.kafka_broker_root_volume_size
    key_pair = var.kafka_broker_key_pair == "" ? var.key_pair : var.kafka_broker_key_pair
    tags = merge(var.default_tags, var.kafka_broker_tags)
    subnet_ids = length(var.kafka_broker_subnet_ids) > 0 ? var.kafka_broker_subnet_ids : var.subnet_ids
    multi_az = var.multi_az && var.kafka_broker_multi_az
    security_group_ids = length(var.kafka_broker_security_group_ids) > 0 ? var.kafka_broker_security_group_ids : var.security_group_ids
    dns_zone_id = var.kafka_broker_dns_zone_id == "" ? var.dns_zone_id : var.kafka_broker_dns_zone_id
    dns_ttl = var.kafka_broker_dns_ttl
    name_template = var.kafka_broker_name_template
    dns_template = var.kafka_broker_dns_template
    sg_name = var.kafka_broker_sg_name
    kafka_connect_sg_ids = [module.cp-aws-kafka_connect.security_group]
    ksql_sg_ids = [module.cp-aws-ksql.security_group]
    rest_proxy_sg_id = module.cp-aws-rest_proxy.security_group
    schema_registry_sg_id = module.cp-aws-schema_registry.security_group
    control_center_sg_id = module.cp-aws-control_center.security_group
    
    extra_template_vars = merge(var.kafka_broker_extra_template_vars, var.extra_template_vars)
    user_data_template_vars = merge(var.kafka_broker_user_data_template_vars, var.user_data_template_vars)
    user_data_template = var.kafka_broker_user_data_template
    vpc_id = var.vpc_id
    enable_sg_creation = var.enable_sg_creation ? var.kafka_broker_enable_sg_creation : false
    enable_dns_creation = var.enable_dns_creation && var.kafka_broker_enable_dns_creation
    
    port_external_range = var.kafka_broker_port_external_range
    port_internal_range = var.kafka_broker_port_internal_range
    external_access_security_group_ids = var.kafka_broker_external_access_security_group_ids
    external_access_cidrs = var.kafka_broker_external_access_cidrs
    
    extra_ebs_volumes = var.kafka_broker_extra_ebs_volumes
    vol_data_size = var.kafka_broker_vol_data_size
    vol_data_device_name = var.kafka_broker_vol_data_device_name
    vol_data_type = var.kafka_broker_vol_data_type

    monitoring_security_group_ids = var.monitoring_security_group_ids
    monitoring_cidrs = var.monitoring_cidrs
    prometheus_enabled = var.prometheus_enabled
    jolokia_enabled = var.jolokia_enabled
    prometheus_port = var.kafka_broker_prometheus_port
    jolokia_port = var.kafka_broker_jolokia_port
}

module "cp-aws-kafka_connect" {
    source = "./modules/kafka_connect"
    
    providers = {
        aws = aws
        aws.dns = aws.dns
    }

    servers = var.kafka_connect_servers
    image_id = var.kafka_connect_image_id == "" ? var.image_id : var.kafka_connect_image_id
    instance_type = var.kafka_connect_instance_type
    root_volume_size = var.kafka_connect_root_volume_size
    key_pair = var.kafka_connect_key_pair == "" ? var.key_pair : var.kafka_connect_key_pair
    tags = merge(var.default_tags, var.kafka_connect_tags)
    subnet_ids = length(var.kafka_connect_subnet_ids) > 0 ? var.kafka_connect_subnet_ids : var.subnet_ids
    multi_az = var.multi_az && var.kafka_connect_multi_az
    security_group_ids = length(var.kafka_connect_security_group_ids) > 0 ? var.kafka_connect_security_group_ids : var.security_group_ids
    dns_zone_id = var.kafka_connect_dns_zone_id == "" ? var.dns_zone_id : var.kafka_connect_dns_zone_id
    dns_ttl = var.kafka_connect_dns_ttl
    name_template = var.kafka_connect_name_template
    dns_template = var.kafka_connect_dns_template
    sg_name = var.kafka_connect_sg_name
    control_center_sg_id = module.cp-aws-control_center.security_group
    
    extra_template_vars = merge(var.kafka_connect_extra_template_vars, var.extra_template_vars)
    user_data_template_vars = merge(var.kafka_connect_user_data_template_vars, var.user_data_template_vars)
    user_data_template = var.kafka_connect_user_data_template
    vpc_id = var.vpc_id
    enable_sg_creation = var.enable_sg_creation ? var.kafka_connect_enable_sg_creation : false
    enable_dns_creation = var.enable_dns_creation && var.kafka_connect_enable_dns_creation
    
    port_external_range = var.kafka_connect_port_external_range
    port_internal_range = var.kafka_connect_port_internal_range
    external_access_security_group_ids = var.kafka_connect_external_access_security_group_ids
    external_access_cidrs = var.kafka_connect_external_access_cidrs
    
    extra_ebs_volumes = var.kafka_connect_extra_ebs_volumes

    monitoring_security_group_ids = var.monitoring_security_group_ids
    monitoring_cidrs = var.monitoring_cidrs
    prometheus_enabled = var.prometheus_enabled
    jolokia_enabled = var.jolokia_enabled
    prometheus_port = var.kafka_connect_prometheus_port
    jolokia_port = var.kafka_connect_jolokia_port
}

module "cp-aws-control_center" {
    source = "./modules/control_center"
    
    providers = {
        aws = aws
        aws.dns = aws.dns
    }

    servers = var.control_center_servers
    image_id = var.control_center_image_id == "" ? var.image_id : var.control_center_image_id
    instance_type = var.control_center_instance_type
    root_volume_size = var.control_center_root_volume_size
    key_pair = var.control_center_key_pair == "" ? var.key_pair : var.control_center_key_pair
    tags = merge(var.default_tags, var.control_center_tags)
    subnet_ids = length(var.control_center_subnet_ids) > 0 ? var.control_center_subnet_ids : var.subnet_ids
    multi_az = var.multi_az && var.control_center_multi_az
    security_group_ids = length(var.control_center_security_group_ids) > 0 ? var.control_center_security_group_ids : var.security_group_ids
    dns_zone_id = var.control_center_dns_zone_id == "" ? var.dns_zone_id : var.control_center_dns_zone_id
    dns_ttl = var.control_center_dns_ttl
    name_template = var.control_center_name_template
    dns_template = var.control_center_dns_template
    sg_name = var.control_center_sg_name
    
    extra_template_vars = merge(var.control_center_extra_template_vars, var.extra_template_vars)
    user_data_template_vars = merge(var.control_center_user_data_template_vars, var.user_data_template_vars)
    user_data_template = var.control_center_user_data_template
    vpc_id = var.vpc_id
    enable_sg_creation = var.enable_sg_creation ? var.control_center_enable_sg_creation : false
    enable_dns_creation = var.enable_dns_creation && var.control_center_enable_dns_creation
    
    port_external_range = var.control_center_port_external_range
    port_internal_range = var.control_center_port_internal_range
    external_access_security_group_ids = var.control_center_external_access_security_group_ids
    external_access_cidrs = var.control_center_external_access_cidrs
    
    extra_ebs_volumes = var.control_center_extra_ebs_volumes
    vol_data_size = var.control_center_vol_data_size
    vol_data_device_name = var.control_center_vol_data_device_name
}

module "cp-aws-ksql" {
    source = "./modules/ksql"
    
    providers = {
        aws = aws
        aws.dns = aws.dns
    }

    servers = var.ksql_servers
    image_id = var.ksql_image_id == "" ? var.image_id : var.ksql_image_id
    instance_type = var.ksql_instance_type
    root_volume_size = var.ksql_root_volume_size
    key_pair = var.ksql_key_pair == "" ? var.key_pair : var.ksql_key_pair
    tags = merge(var.default_tags, var.ksql_tags)
    subnet_ids = length(var.ksql_subnet_ids) > 0 ? var.ksql_subnet_ids : var.subnet_ids
    multi_az = var.multi_az && var.ksql_multi_az
    security_group_ids = length(var.ksql_security_group_ids) > 0 ? var.ksql_security_group_ids : var.security_group_ids
    dns_zone_id = var.ksql_dns_zone_id == "" ? var.dns_zone_id : var.ksql_dns_zone_id
    dns_ttl = var.ksql_dns_ttl
    name_template = var.ksql_name_template
    dns_template = var.ksql_dns_template
    sg_name = var.ksql_sg_name
    control_center_sg_id = module.cp-aws-control_center.security_group
    
    extra_template_vars = merge(var.ksql_extra_template_vars, var.extra_template_vars)
    user_data_template_vars = merge(var.ksql_user_data_template_vars, var.user_data_template_vars)
    user_data_template = var.ksql_user_data_template
    vpc_id = var.vpc_id
    enable_sg_creation = var.enable_sg_creation ? var.ksql_enable_sg_creation : false
    enable_dns_creation = var.enable_dns_creation && var.ksql_enable_dns_creation
    
    port_external_range = var.ksql_port_external_range
    port_internal_range = var.ksql_port_internal_range
    external_access_security_group_ids = var.ksql_external_access_security_group_ids
    external_access_cidrs = var.ksql_external_access_cidrs
    
    extra_ebs_volumes = var.ksql_extra_ebs_volumes
    vol_data_size = var.ksql_vol_data_size
    vol_data_device_name = var.ksql_vol_data_device_name

    monitoring_security_group_ids = var.monitoring_security_group_ids
    monitoring_cidrs = var.monitoring_cidrs
    prometheus_enabled = var.prometheus_enabled
    jolokia_enabled = var.jolokia_enabled
    prometheus_port = var.ksql_prometheus_port
    jolokia_port = var.ksql_jolokia_port
}

module "cp-aws-rest_proxy" {
    source = "./modules/rest_proxy"
    
    providers = {
        aws = aws
        aws.dns = aws.dns
    }

    servers = var.rest_proxy_servers
    image_id = var.rest_proxy_image_id == "" ? var.image_id : var.rest_proxy_image_id
    instance_type = var.rest_proxy_instance_type
    root_volume_size = var.rest_proxy_root_volume_size
    key_pair = var.rest_proxy_key_pair == "" ? var.key_pair : var.rest_proxy_key_pair
    tags = merge(var.default_tags, var.rest_proxy_tags)
    subnet_ids = length(var.rest_proxy_subnet_ids) > 0 ? var.rest_proxy_subnet_ids : var.subnet_ids
    multi_az = var.multi_az && var.rest_proxy_multi_az
    security_group_ids = length(var.rest_proxy_security_group_ids) > 0 ? var.rest_proxy_security_group_ids : var.security_group_ids
    dns_zone_id = var.rest_proxy_dns_zone_id == "" ? var.dns_zone_id : var.rest_proxy_dns_zone_id
    dns_ttl = var.rest_proxy_dns_ttl
    name_template = var.rest_proxy_name_template
    dns_template = var.rest_proxy_dns_template
    sg_name = var.rest_proxy_sg_name
    
    extra_template_vars = merge(var.rest_proxy_extra_template_vars, var.extra_template_vars)
    user_data_template_vars = merge(var.rest_proxy_user_data_template_vars, var.user_data_template_vars)
    user_data_template = var.rest_proxy_user_data_template
    vpc_id = var.vpc_id
    enable_sg_creation = var.enable_sg_creation ? var.rest_proxy_enable_sg_creation : false
    enable_dns_creation = var.enable_dns_creation && var.rest_proxy_enable_dns_creation
    
    port_external_range = var.rest_proxy_port_external_range
    port_internal_range = var.rest_proxy_port_internal_range
    external_access_security_group_ids = var.rest_proxy_external_access_security_group_ids
    external_access_cidrs = var.rest_proxy_external_access_cidrs

    monitoring_security_group_ids = var.monitoring_security_group_ids
    monitoring_cidrs = var.monitoring_cidrs
    prometheus_enabled = var.prometheus_enabled
    jolokia_enabled = var.jolokia_enabled
    prometheus_port = var.rest_proxy_prometheus_port
    jolokia_port = var.rest_proxy_jolokia_port
}

module "cp-aws-schema_registry" {
    source = "./modules/schema_registry"
    
    providers = {
        aws = aws
        aws.dns = aws.dns
    }

    servers = var.schema_registry_servers
    image_id = var.schema_registry_image_id == "" ? var.image_id : var.schema_registry_image_id
    instance_type = var.schema_registry_instance_type
    root_volume_size = var.schema_registry_root_volume_size
    key_pair = var.schema_registry_key_pair == "" ? var.key_pair : var.schema_registry_key_pair
    tags = merge(var.default_tags, var.schema_registry_tags)
    subnet_ids = length(var.schema_registry_subnet_ids) > 0 ? var.schema_registry_subnet_ids : var.subnet_ids
    multi_az = var.multi_az && var.schema_registry_multi_az
    security_group_ids = length(var.schema_registry_security_group_ids) > 0 ? var.schema_registry_security_group_ids : var.security_group_ids
    dns_zone_id = var.schema_registry_dns_zone_id == "" ? var.dns_zone_id : var.schema_registry_dns_zone_id
    dns_ttl = var.schema_registry_dns_ttl
    name_template = var.schema_registry_name_template
    dns_template = var.schema_registry_dns_template
    sg_name = var.schema_registry_sg_name
    kafka_connect_sg_ids = [module.cp-aws-kafka_connect.security_group]
    ksql_sg_ids = [module.cp-aws-ksql.security_group]
    rest_proxy_sg_id = module.cp-aws-rest_proxy.security_group
    control_center_sg_id = module.cp-aws-control_center.security_group
    
    extra_template_vars = merge(var.schema_registry_extra_template_vars, var.extra_template_vars)
    user_data_template_vars = merge(var.schema_registry_user_data_template_vars, var.user_data_template_vars)
    user_data_template = var.schema_registry_user_data_template
    vpc_id = var.vpc_id
    enable_sg_creation = var.enable_sg_creation ? var.schema_registry_enable_sg_creation : false
    enable_dns_creation = var.enable_dns_creation && var.schema_registry_enable_dns_creation
    
    port_external_range = var.schema_registry_port_external_range
    port_internal_range = var.schema_registry_port_internal_range
    external_access_security_group_ids = var.schema_registry_external_access_security_group_ids
    external_access_cidrs = var.schema_registry_external_access_cidrs

    monitoring_security_group_ids = var.monitoring_security_group_ids
    monitoring_cidrs = var.monitoring_cidrs
    prometheus_enabled = var.prometheus_enabled
    jolokia_enabled = var.jolokia_enabled
    prometheus_port = var.schema_registry_prometheus_port
    jolokia_port = var.schema_registry_jolokia_port
}