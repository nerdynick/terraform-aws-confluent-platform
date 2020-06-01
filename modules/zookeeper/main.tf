resource "aws_security_group" "my_security_group" {
    count = var.enable_sg_creation ? 1 : 0
    name = var.sg_name
    description = "Confluent Platform - Zookeeper"
    vpc_id = var.vpc_id
    
    tags = var.tags
    
    ingress {
        description = "Zookeeper - Internal - Client"
        from_port   = 2181
        to_port     = 2181
        protocol    = "tcp"
        self        =  true
    }
    
    ingress {
        description = "Zookeeper - External - Kafka Brokers"
        from_port   = 2181
        to_port     = 2181
        protocol    = "tcp"
        security_groups = [var.kafka_broker_sg_id]
    }
    
    ingress {
        description = "Zookeeper - Internal - Leader/Follow"
        from_port   = 2888
        to_port     = 2888
        protocol    = "tcp"
        self        =  true
    }
    
    ingress {
        description = "Zookeeper - Internal - Leader Election"
        from_port   = 3888
        to_port     = 3888
        protocol    = "tcp"
        self        =  true
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
    subnet_id = var.subnet_id
    security_groups_ids = concat(var.security_groups_ids, aws_security_group.my_security_group.*.id)
    dns_zone_id = var.dns_zone_id
    dns_ttl = var.dns_ttl
    name_template = var.name_template
    dns_template = var.dns_template
    enable_dns_creation = var.enable_dns_creation
}