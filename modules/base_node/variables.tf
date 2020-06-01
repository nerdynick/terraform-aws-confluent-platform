variable "servers" {
    type = number
    default = 0
    description = "Number of Nodes/Instances to create"
}

#Instance Related Vars
variable "image_id" {
    type = string
    description = "AMI/VM image ID to use in creating each instance"
}
variable "instance_type" {
    type = string
    default = "t3.medium"
    description = "Instance Type to use as defined by the provide"
}
variable "root_volume_size" {
    type = number
    default = 15
    description = "Root ephemeral disk size in GBs"
}
variable "key_pair" {
    type = string
    description = "Key Pairs - Key Name to install/use for the ROOT user" 
}
variable "tags" {
    type = map
    description = "Default set of tags to include on all entries where tagging is available. By default `name` and `Name` will be included where logical."
}

#Network Related Vars
variable "subnet_id" {
    type = string
    description = "Subnet where all instances should live within"
}

variable "security_groups_ids" {
    type = list
    default = []
    description = "Extra security groups that you wish to have the instances added to"
}

#DNS Related Vars
variable "dns_zone_id" {
    type = string
    description = "Route53 Zone ID to add each instances DNS record to"
}
variable "dns_ttl" {
    type = string
    default = "300"
    description = "Default DNS record TTL"
}
variable "enable_dns_creation" {
    type = bool
    default = true
    description = "Generate Route53 entries for all created resources"
}

variable "name_template" {
    type = string
    default = "$${format(\"%02.0f\", itemcount)}"
    description = "Terraform template string to generate instance names with. `itemcount` will be provided, along with the value provided in `extra_template_vars`."
}
variable "dns_template" {
    type = string
    default = "$${name}"
    description = "Terraform template string to generate the DNS entry value. `itemcount` and `name` will be provided, along with the value provided in `extra_template_vars`."
}
variable "extra_template_vars" {
    type = map
    default = {}
    description = "Default set of additional template vars to include when rendering the `dns_template` and `name_template`. Note `name` and `itemcount` are reserved names." 
}