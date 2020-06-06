resource "aws_security_group" "my_security_group" {
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
}