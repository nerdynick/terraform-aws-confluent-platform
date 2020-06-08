###########################
# C3 Vars
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
    default = {}
    description = "What tags to assign to the Security Group(s) and EC2 instances"
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
    default = "ccc$${format(\"%02.0f\", itemcount)}"
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
    default = "CP_Control_Center"
    description = "Name/Name Prefix to use when creating Security Groups(s)"
}
variable "port_external_range" {
    type = list(object({from=number,to=number}))
    default = [{from=9021,to=9021}]
    description = "External Port Ranges to Expose"
}
variable "port_internal_range" {
    type = list(object({from=number,to=number}))
    default = [{from=9021,to=9021}]
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
}

variable "vol_data_size" {
    type = number
    default = 300
}
variable "vol_data_device_name" {
    type = string
    default = "/dev/sdf"
}