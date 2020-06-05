resource "aws_security_group" "security_group" {
    count = var.enable_sg_creation ? 1 : 0
    name = var.sg_name
    description = "Confluent Platform - ${var.component_name}"
    vpc_id = var.vpc_id
    
    tags = var.tags
    
    dynamic "ingress" {
        for_each = var.port_external_range
        content {
            description = "${var.component_name} - External"
            from_port   = ingress.value.from
            to_port     = ingress.value.to
            protocol    = "tcp"
            security_groups = var.external_access_security_group_ids
            cidr_blocks = var.external_access_cidrs
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