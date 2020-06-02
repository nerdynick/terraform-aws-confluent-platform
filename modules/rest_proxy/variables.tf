###########################
# RESTProxy Vars
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
    default = "t3.small"
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

#Network Related Vars
variable "subnet_id" {
    type = string
}

variable "security_groups_ids" {
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
    default = "rest$${format(\"%02.0f\", itemcount)}"
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
    default = "CP_REST_Proxy"
    description = "Name/Name Prefix to use when creating Security Groups(s)"
}
variable "port_external_range" {
    type = list(object({from=number,to=number}))
    default = [{from=8082,to=8082}]
    description = "External Port Ranges to Expose"
}
variable "port_internal_range" {
    type = list(object({from=number,to=number}))
    default = [{from=8082,to=8082}]
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