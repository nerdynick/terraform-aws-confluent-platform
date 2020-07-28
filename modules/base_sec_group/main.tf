provider "aws" {
    alias = "default"
}

locals {
    prometheus_port_range = var.prometheus_enabled ? [{from: var.prometheus_port,to: var.prometheus_port}] : []
    jolokia_port_range = var.jolokia_enabled ? [{from: var.jolokia_port,to: var.jolokia_port}] : []
    monitoring_port_range = concat(local.prometheus_port_range, local.jolokia_port_range)
}
resource "aws_security_group" "my_security_group" {
    provider        = aws.default
    count = var.enable_sg_creation ? 1 : 0
    name = var.sg_name
    description = "Confluent Platform - ${var.component_name}"
    vpc_id = var.vpc_id
    
    tags = merge({
        Name: var.sg_name
    }, var.tags)
    
    dynamic "ingress" {
        for_each = var.port_external_range
        content {
            description = "${var.component_name} - External - SecGroups"
            from_port   = ingress.value.from
            to_port     = ingress.value.to
            protocol    = "tcp"
            security_groups = compact(var.external_access_security_group_ids)
        }
    }
    dynamic "ingress" {
        for_each = var.port_external_range
        content {
            description = "${var.component_name} - External - CIDRs"
            from_port   = ingress.value.from
            to_port     = ingress.value.to
            protocol    = "tcp"
            cidr_blocks = compact(var.external_access_cidrs)
        }
    }
    dynamic "ingress" {
        for_each = var.port_internal_range
        content {
            description = "${var.component_name} - Internal"
            from_port   = ingress.value.from
            to_port     = ingress.value.to
            protocol    = "tcp"
            self        = true
        }
    }

    dynamic "ingress" {
        for_each = local.monitoring_port_range
        content {
            description = "${var.component_name} - Monitoring - SecGroups"
            from_port   = ingress.value.from
            to_port     = ingress.value.to
            protocol    = "tcp"
            security_groups = compact(var.monitoring_security_group_ids)
        }
    }
    dynamic "ingress" {
        for_each = local.monitoring_port_range
        content {
            description = "${var.component_name} - Monitoring - CIDRs"
            from_port   = ingress.value.from
            to_port     = ingress.value.to
            protocol    = "tcp"
            cidr_blocks = compact(var.monitoring_cidrs)
        }
    }
}