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
    description = "Name/Name Prefix to use when creating Security Groups(s)"
}
variable "port_external_range" {
    type = list(object({from=number,to=number}))
    description = "External Port Ranges to Expose"
}
variable "port_internal_range" {
    type = list(object({from=number,to=number}))
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
variable "component_name" {
    type = string
    description = "Component name to use in templated Names/Decriptions of policies and groups"
}
variable "tags" {
    type = map
    default = {}
    description = "What tags to assign to the Security Group(s)"
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
}
variable "prometheus_enabled" {
    type = bool
}

variable "jolokia_port" {
    type = number
}
variable "jolokia_enabled" {
    type = bool
}