###########################
# KSQL Vars
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
    default = "ksql$${format(\"%02.0f\", itemcount)}"
}
variable "dns_template" {
    type = string
    default = "$${name}"
}
variable "extra_template_vars" {
    type = map
    default = {}
}