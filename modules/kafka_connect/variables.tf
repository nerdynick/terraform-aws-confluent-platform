###########################
# Connect Vars
###########################
variable "servers" {
    type = number
    default = 0
}

#Instance Related Vars
variable "image_id" {
    type = string
}
variable "instance_type" {
    type = string
    default = "t3.medium"
}
variable "root_volume_size" {
    type = number
    default = 15
}
variable "key_pair" {
    type = string
}
variable "tags" {
    type = map
}
variable "multi_az" {
    type = bool
    default = true
    description = "Should all the instances be proportianently spread among all the Subnets or just stay in the first subnet"
}

#Network Related Vars
variable "subnet_ids" {
    type = list(string)
}

variable "security_group_ids" {
    type = list
    default = []
}

#DNS Related Vars
variable "dns_zone_id" {
    type = string
}
variable "dns_ttl" {
    type = string
    default = "300"
}

variable "name_template" {
    type = string
    default = "connect$${format(\"%02.0f\", itemcount)}"
}
variable "dns_template" {
    type = string
    default = "$${name}"
}
variable "enable_dns_creation" {
    type = bool
    default = true
    description = "Generate Route53 entries for all created resources"
}
variable "extra_template_vars" {
    type = map
    default = {}
}

#SG Related Vars
variable "vpc_id" {
    type = string
    description = "VPC ID that Resources should exist in"
}
variable "enable_sg_creation" {
    type = bool
    default = true
    description = "Flag to enable the creation of needed Security Group(s)"
}
variable "sg_name" {
    type = string
    default = "CP_Kafka_Connect"
    description = "Name/Name Prefix to use when creating Security Groups(s)"
}
variable "port_external_range" {
    type = list(object({from=number,to=number}))
    default = [{from=8083,to=8083}]
    description = "External Port Ranges to Expose"
}
variable "port_internal_range" {
    type = list(object({from=number,to=number}))
    default = [{from=8083,to=8083}]
    description = "Internal Port Ranges to Expose"
}
variable "external_access_security_group_ids" {
    type = list
    default = []
    description = "Other Security Groups you will tro grant access to the externalized ports"
}
variable "external_access_cidrs" {
    type = list
    default = []
    description = "CIDRs you will tro grant access to the externalized ports"
}
variable "control_center_sg_id" {
    type = string
    default = ""
}

#EBS Volumes
variable "extra_ebs_volumes" {
    type = list(object({
        name: string,
        device_name: string,
        encrypted: bool,
        kms_key_id: string,
        size: number,
        type: string,
        tags: map(string)
    }))
    default = []
}

#Monitoring
variable "monitoring_security_group_ids"{
    type = list
    default = []
    description = "Collection of Security Groups that need access to monitoring this component"
}
variable "monitoring_cidrs"{
    type = list
    default = []
    description = "Collection of CIDRS that need access to monitoring this component"
}

variable "prometheus_port" {
    type = number
    default = 8077
    description = "Port on which the Prometheus Agent is running"
}
variable "prometheus_enabled" {
    type = bool
    default = true
}

variable "jolokia_port" {
    type = number
    default = 7773
    description = "Port on which the Jolokia Agent is running"
}
variable "jolokia_enabled" {
    type = bool
    default = true
}