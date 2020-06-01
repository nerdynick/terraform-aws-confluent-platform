module "cp-aws-zookeeper" {
    source = "./modules/zookeeper"

    servers = var.zookeeper_servers
    image_id = var.zookeeper_image_id == "" ? var.image_id : var.zookeeper_image_id
    instance_type = var.zookeeper_instance_type
    root_volume_size = var.zookeeper_root_volume_size
    key_pair = var.zookeeper_key_pair == "" ? var.key_pair : var.zookeeper_key_pair
    tags = merge(var.default_tags, var.zookeeper_tags)
    subnet_id = var.zookeeper_subnet_id == "" ? var.subnet_id : var.zookeeper_subnet_id
    security_groups_ids = var.zookeeper_security_groups_ids
    dns_zone_id = var.zookeeper_dns_zone_id
    dns_ttl = var.zookeeper_dns_ttl
    name_template = var.zookeeper_name_template
    dns_template = var.zookeeper_dns_template
    sg_name = var.zookeeper_sg_name
    kafka_broker_sg_id = module.cp-aws-kafka_broker.security_group
    
    extra_template_vars = var.extra_template_vars
    vpc_id = var.vpc_id
    enable_sg_creation = var.enable_sg_creation ? var.zookeeper_enable_sg_creation : false
}

module "cp-aws-kafka_broker" {
    source = "./modules/kafka_broker"

    servers = var.kafka_broker_servers
    image_id = var.kafka_broker_image_id == "" ? var.image_id : var.kafka_broker_image_id
    instance_type = var.kafka_broker_instance_type
    root_volume_size = var.kafka_broker_root_volume_size
    key_pair = var.kafka_broker_key_pair == "" ? var.key_pair : var.kafka_broker_key_pair
    tags = merge(var.default_tags, var.kafka_broker_tags)
    subnet_id = var.kafka_broker_subnet_id == "" ? var.subnet_id : var.kafka_broker_subnet_id
    security_groups_ids = var.kafka_broker_security_groups_ids
    dns_zone_id = var.kafka_broker_dns_zone_id
    dns_ttl = var.kafka_broker_dns_ttl
    name_template = var.kafka_broker_name_template
    dns_template = var.kafka_broker_dns_template
    sg_name = var.kafka_broker_sg_name
    kafka_connect_sg_ids = [module.cp-aws-kafka_connect.security_group]
    ksql_sg_ids = [module.cp-aws-ksql.security_group]
    rest_proxy_sg_id = module.cp-aws-rest_proxy.security_group
    schema_registry_sg_id = module.cp-aws-schema_registry.security_group
    control_center_sg_id = module.cp-aws-control_center.security_group
    
    extra_template_vars = var.extra_template_vars
    vpc_id = var.vpc_id
    enable_sg_creation = var.enable_sg_creation ? var.kafka_broker_enable_sg_creation : false
}

module "cp-aws-kafka_connect" {
    source = "./modules/kafka_connect"

    servers = var.kafka_connect_servers
    image_id = var.kafka_connect_image_id == "" ? var.image_id : var.kafka_connect_image_id
    instance_type = var.kafka_connect_instance_type
    root_volume_size = var.kafka_connect_root_volume_size
    key_pair = var.kafka_connect_key_pair == "" ? var.key_pair : var.kafka_connect_key_pair
    tags = merge(var.default_tags, var.kafka_connect_tags)
    subnet_id = var.kafka_connect_subnet_id == "" ? var.subnet_id : var.kafka_connect_subnet_id
    security_groups_ids = var.kafka_connect_security_groups_ids
    dns_zone_id = var.kafka_connect_dns_zone_id
    dns_ttl = var.kafka_connect_dns_ttl
    name_template = var.kafka_connect_name_template
    dns_template = var.kafka_connect_dns_template
    sg_name = var.kafka_connect_sg_name
    control_center_sg_id = module.cp-aws-control_center.security_group
    
    extra_template_vars = var.extra_template_vars
    vpc_id = var.vpc_id
    enable_sg_creation = var.enable_sg_creation ? var.kafka_connect_enable_sg_creation : false
}

module "cp-aws-control_center" {
    source = "./modules/control_center"

    servers = var.control_center_servers
    image_id = var.control_center_image_id == "" ? var.image_id : var.control_center_image_id
    instance_type = var.control_center_instance_type
    root_volume_size = var.control_center_root_volume_size
    key_pair = var.control_center_key_pair == "" ? var.key_pair : var.control_center_key_pair
    tags = merge(var.default_tags, var.control_center_tags)
    subnet_id = var.control_center_subnet_id == "" ? var.subnet_id : var.control_center_subnet_id
    security_groups_ids = var.control_center_security_groups_ids
    dns_zone_id = var.control_center_dns_zone_id
    dns_ttl = var.control_center_dns_ttl
    name_template = var.control_center_name_template
    dns_template = var.control_center_dns_template
    sg_name = var.control_center_sg_name
    
    extra_template_vars = var.extra_template_vars
    vpc_id = var.vpc_id
    enable_sg_creation = var.enable_sg_creation ? var.control_center_enable_sg_creation : false
}

module "cp-aws-ksql" {
    source = "./modules/ksql"

    servers = var.ksql_servers
    image_id = var.ksql_image_id == "" ? var.image_id : var.ksql_image_id
    instance_type = var.ksql_instance_type
    root_volume_size = var.ksql_root_volume_size
    key_pair = var.ksql_key_pair == "" ? var.key_pair : var.ksql_key_pair
    tags = merge(var.default_tags, var.ksql_tags)
    subnet_id = var.ksql_subnet_id == "" ? var.subnet_id : var.ksql_subnet_id
    security_groups_ids = var.ksql_security_groups_ids
    dns_zone_id = var.ksql_dns_zone_id
    dns_ttl = var.ksql_dns_ttl
    name_template = var.ksql_name_template
    dns_template = var.ksql_dns_template
    sg_name = var.ksql_sg_name
    control_center_sg_id = module.cp-aws-control_center.security_group
    
    extra_template_vars = var.extra_template_vars
    vpc_id = var.vpc_id
    enable_sg_creation = var.enable_sg_creation ? var.ksql_enable_sg_creation : false
}

module "cp-aws-rest_proxy" {
    source = "./modules/rest_proxy"

    servers = var.rest_proxy_servers
    image_id = var.rest_proxy_image_id == "" ? var.image_id : var.rest_proxy_image_id
    instance_type = var.rest_proxy_instance_type
    root_volume_size = var.rest_proxy_root_volume_size
    key_pair = var.rest_proxy_key_pair == "" ? var.key_pair : var.rest_proxy_key_pair
    tags = merge(var.default_tags, var.rest_proxy_tags)
    subnet_id = var.rest_proxy_subnet_id == "" ? var.subnet_id : var.rest_proxy_subnet_id
    security_groups_ids = var.rest_proxy_security_groups_ids
    dns_zone_id = var.rest_proxy_dns_zone_id
    dns_ttl = var.rest_proxy_dns_ttl
    name_template = var.rest_proxy_name_template
    dns_template = var.rest_proxy_dns_template
    sg_name = var.rest_proxy_sg_name
    
    extra_template_vars = var.extra_template_vars
    vpc_id = var.vpc_id
    enable_sg_creation = var.enable_sg_creation ? var.rest_proxy_enable_sg_creation : false
}

module "cp-aws-schema_registry" {
    source = "./modules/schema_registry"

    servers = var.schema_registry_servers
    image_id = var.schema_registry_image_id == "" ? var.image_id : var.schema_registry_image_id
    instance_type = var.schema_registry_instance_type
    root_volume_size = var.schema_registry_root_volume_size
    key_pair = var.schema_registry_key_pair == "" ? var.key_pair : var.schema_registry_key_pair
    tags = merge(var.default_tags, var.schema_registry_tags)
    subnet_id = var.schema_registry_subnet_id == "" ? var.subnet_id : var.schema_registry_subnet_id
    security_groups_ids = var.schema_registry_security_groups_ids
    dns_zone_id = var.schema_registry_dns_zone_id
    dns_ttl = var.schema_registry_dns_ttl
    name_template = var.schema_registry_name_template
    dns_template = var.schema_registry_dns_template
    sg_name = var.schema_registry_sg_name
    kafka_connect_sg_ids = [module.cp-aws-kafka_connect.security_group]
    ksql_sg_ids = [module.cp-aws-ksql.security_group]
    rest_proxy_sg_id = module.cp-aws-rest_proxy.security_group
    control_center_sg_id = module.cp-aws-control_center.security_group
    
    extra_template_vars = var.extra_template_vars
    vpc_id = var.vpc_id
    enable_sg_creation = var.enable_sg_creation ? var.schema_registry_enable_sg_creation : false
}