variable "extra_template_vars" {
    type = map
    default = {}
}
variable "vpc_id" {
    type = string
}
variable "subnet_id" {
    type = string
}
variable "image_id" {
    type = string
}
variable "enable_sg_creation" {
    type = bool
    default = true
}
variable "key_pair" {
    type = string
}
variable "default_tags" {
    type = map
    default = {}
}

###########################
# Zookeeper Vars
###########################
variable "zookeeper_servers" {
    type = number
    default = 1
}

#Instance Related Vars
variable "zookeeper_image_id" {
    type = string
    default = ""
}
variable "zookeeper_instance_type" {
    type = string
    default = "t3.small"
}
variable "zookeeper_root_volume_size" {
    type = number
    default = 15
}
variable "zookeeper_key_pair" {
    type = string
    default = ""
}
variable "zookeeper_tags" {
    type = map
    default = {}
}

#Network Related Vars
variable "zookeeper_subnet_id" {
    type = string
    default = ""
}

variable "zookeeper_security_groups_ids" {
    type = list
    default = []
}

#DNS Related Vars
variable "zookeeper_dns_zone_id" {
    type = string
}
variable "zookeeper_dns_ttl" {
    type = string
    default = "300"
}

variable "zookeeper_name_template" {
    type = string
    default = "zk$${format('%02f', itemcount)}"
}
variable "zookeeper_dns_template" {
    type = string
    default = "$${name}"
}
variable "zookeeper_sg_name" {
    type = string
    default = "CP_REST_Proxy"
}
variable "zookeeper_enable_sg_creation" {
    type = bool
    default = true
}

###########################
# Broker Vars
###########################
variable "kafka_broker_servers" {
    type = number
    default = 1
}

#Instance Related Vars
variable "kafka_broker_image_id" {
    type = string
    default = ""
}
variable "kafka_broker_instance_type" {
    type = string
    default = "t3.medium"
}
variable "kafka_broker_root_volume_size" {
    type = number
    default = 30
}
variable "kafka_broker_key_pair" {
    type = string
    default = ""
}
variable "kafka_broker_tags" {
    type = map
    default = {}
}

#Network Related Vars
variable "kafka_broker_subnet_id" {
    type = string
    default = ""
}

variable "kafka_broker_security_groups_ids" {
    type = list
    default = []
}

#DNS Related Vars
variable "kafka_broker_dns_zone_id" {
    type = string
}
variable "kafka_broker_dns_ttl" {
    type = string
    default = "300"
}

variable "kafka_broker_name_template" {
    type = string
    default = "kfk$${format('%02f', itemcount)}"
}
variable "kafka_broker_dns_template" {
    type = string
    default = "$${name}"
}
variable "kafka_broker_sg_name" {
    type = string
    default = "CP_REST_Proxy"
}
variable "kafka_broker_enable_sg_creation" {
    type = bool
    default = true
}

###########################
# Connect Vars
###########################
variable "kafka_connect_servers" {
    type = number
    default = 0
}

#Instance Related Vars
variable "kafka_connect_image_id" {
    type = string
    default = ""
}
variable "kafka_connect_instance_type" {
    type = string
    default = "t3.medium"
}
variable "kafka_connect_root_volume_size" {
    type = number
    default = 15
}
variable "kafka_connect_key_pair" {
    type = string
    default = ""
}
variable "kafka_connect_tags" {
    type = map
    default = {}
}

#Network Related Vars
variable "kafka_connect_subnet_id" {
    type = string
    default = ""
}

variable "kafka_connect_security_groups_ids" {
    type = list
    default = []
}

#DNS Related Vars
variable "kafka_connect_dns_zone_id" {
    type = string
}
variable "kafka_connect_dns_ttl" {
    type = string
    default = "300"
}

variable "kafka_connect_name_template" {
    type = string
    default = "connect$${format('%02f', itemcount)}"
}
variable "kafka_connect_dns_template" {
    type = string
    default = "$${name}"
}
variable "kafka_connect_sg_name" {
    type = string
    default = "CP_REST_Proxy"
}
variable "kafka_connect_enable_sg_creation" {
    type = bool
    default = true
}

###########################
# Control Center Vars
###########################
variable "control_center_servers" {
    type = number
    default = 0
}

#Instance Related Vars
variable "control_center_image_id" {
    type = string
    default = ""
}
variable "control_center_instance_type" {
    type = string
    default = "t3.medium"
}
variable "control_center_root_volume_size" {
    type = number
    default = 15
}
variable "control_center_key_pair" {
    type = string
    default = ""
}
variable "control_center_tags" {
    type = map
    default = {}
}

#Network Related Vars
variable "control_center_subnet_id" {
    type = string
    default = ""
}

variable "control_center_security_groups_ids" {
    type = list
    default = []
}

#DNS Related Vars
variable "control_center_dns_zone_id" {
    type = string
}
variable "control_center_dns_ttl" {
    type = string
    default = "300"
}

variable "control_center_name_template" {
    type = string
    default = "ccc$${format('%02f', itemcount)}"
}
variable "control_center_dns_template" {
    type = string
    default = "$${name}"
}
variable "control_center_sg_name" {
    type = string
    default = "CP_REST_Proxy"
}
variable "control_center_enable_sg_creation" {
    type = bool
    default = true
}

###########################
# KSQL Vars
###########################
variable "ksql_servers" {
    type = number
    default = 0
}

#Instance Related Vars
variable "ksql_image_id" {
    type = string
    default = ""
}
variable "ksql_instance_type" {
    type = string
    default = "t3.medium"
}
variable "ksql_root_volume_size" {
    type = number
    default = 15
}
variable "ksql_key_pair" {
    type = string
    default = ""
}
variable "ksql_tags" {
    type = map
    default = {}
}

#Network Related Vars
variable "ksql_subnet_id" {
    type = string
    default = ""
}

variable "ksql_security_groups_ids" {
    type = list
    default = []
}

#DNS Related Vars
variable "ksql_dns_zone_id" {
    type = string
}
variable "ksql_dns_ttl" {
    type = string
    default = "300"
}

variable "ksql_name_template" {
    type = string
    default = "ksql$${format('%02f', itemcount)}"
}
variable "ksql_dns_template" {
    type = string
    default = "$${name}"
}
variable "ksql_sg_name" {
    type = string
    default = "CP_REST_Proxy"
}
variable "ksql_enable_sg_creation" {
    type = bool
    default = true
}

###########################
# RESTProxy Vars
###########################
variable "rest_proxy_servers" {
    type = number
    default = 0
}

#Instance Related Vars
variable "rest_proxy_image_id" {
    type = string
    default = ""
}
variable "rest_proxy_instance_type" {
    type = string
    default = "t3.medium"
}
variable "rest_proxy_root_volume_size" {
    type = number
    default = 15
}
variable "rest_proxy_key_pair" {
    type = string
    default = ""
}
variable "rest_proxy_tags" {
    type = map
    default = {}
}

#Network Related Vars
variable "rest_proxy_subnet_id" {
    type = string
    default = ""
}

variable "rest_proxy_security_groups_ids" {
    type = list
    default = []
}

#DNS Related Vars
variable "rest_proxy_dns_zone_id" {
    type = string
}
variable "rest_proxy_dns_ttl" {
    type = string
    default = "300"
}

variable "rest_proxy_name_template" {
    type = string
    default = "rest$${format('%02f', itemcount)}"
}
variable "rest_proxy_dns_template" {
    type = string
    default = "$${name}"
}
variable "rest_proxy_sg_name" {
    type = string
    default = "CP_REST_Proxy"
}
variable "rest_proxy_enable_sg_creation" {
    type = bool
    default = true
}

###########################
# Schema Registry Vars
###########################
variable "schema_registry_servers" {
    type = number
    default = 0
}

#Instance Related Vars
variable "schema_registry_image_id" {
    type = string
    default = ""
}
variable "schema_registry_instance_type" {
    type = string
    default = "t3.medium"
}
variable "schema_registry_root_volume_size" {
    type = number
    default = 15
}
variable "schema_registry_key_pair" {
    type = string
    default = ""
}
variable "schema_registry_tags" {
    type = map
    default = {}
}

#Network Related Vars
variable "schema_registry_subnet_id" {
    type = string
    default = ""
}

variable "schema_registry_security_groups_ids" {
    type = list
    default = []
}

#DNS Related Vars
variable "schema_registry_dns_zone_id" {
    type = string
}
variable "schema_registry_dns_ttl" {
    type = string
    default = "300"
}

variable "schema_registry_name_template" {
    type = string
    default = "sr$${format('%02f', itemcount)}"
}
variable "schema_registry_dns_template" {
    type = string
    default = "$${name}"
}
variable "schema_registry_sg_name" {
    type = string
    default = "CP_REST_Proxy"
}
variable "schema_registry_enable_sg_creation" {
    type = bool
    default = true
}
