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
variable "multi_az" {
    type = bool
    default = true
    description = "Should all the instances be proportianently spread among all the Subnets or just stay in the first subnet"
}
variable "subnet_ids" {
    type = list(string)
    description = "Subnets where all instances should live within"
}

variable "security_group_ids" {
    type = list(string)
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

#EBS Volumes
variable "ebs_volumes" {
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

#User Data
variable "user_data_template" {
    type = string
    default = ""
    description = "A Shell script to run upon instance startup"
}

variable "user_data_template_vars" {
    type = map
    default = {}
    description = "A collection of variables to give to the user data template during render. These will be in addition to the vars already passed in the extra_template_vars param."
}