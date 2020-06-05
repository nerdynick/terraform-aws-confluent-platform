variable "vpc_id" {
    type = string
    description = "VPC ID that Resources should exist in"
}
variable "subnet_ids" {
    type = list(string)
}
variable "tags" {
    type = map
}
variable "enable_lb_creation" {
    type = bool
    default = true
    description = "Flag to enable the creation of needed Application Load Balancer(s)"
}
variable "lb_name" {
    type = string
    default = "CP-Kafka-Connect"
    description = "Name/Name Prefix to use with LB resources"
}
variable "lb_internal" {
    type = bool
    default = false
    description = "Weather or not the LB should be for internal only use"
}
variable "lb_idle_timeout" {
    type = number
    default = 60
    description = "Idle connection timeout"
}
variable "security_groups_ids" {
    type = list
    default = []
}
variable "port_external_http" {
    type = list(number)
    default = []
}
variable "port_external_https" {
    type = list(number)
    default = []
}
variable "port_external_https_certificate_arn" {
    type = string
    default = null
}
variable "health_check" {
    type = object({
        path: string,
        healthy_threshold: number,
        unhealthy_threshold: number,
        timeout: number,
        matcher: string
    })
}