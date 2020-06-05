module "load_balancer" {
    source  = "terraform-aws-modules/alb/aws"
    version = "5.6.0"
    
    vpc_id = var.vpc_id
    subnets = var.subnet_ids
    enable_cross_zone_load_balancing = false #Will want to auto set is multi-subnets are provided in the future.
    load_balancer_type = "application"
    security_groups = var.security_groups_ids
    tags = merge(var.tags, {
        Name: var.lb_name
    })
    
    create_lb = var.enable_lb_creation ? (var.servers > 0) : false
    name = var.lb_name
    internal = var.lb_internal
    idle_timeout = var.lb_idle_timeout
    
    target_groups = [
        for port in local.external_ports:
        {
            backend_port = port
            backend_protocol = contains(var.port_external_https, port) ? "HTTPS" : "HTTP"
            health_check = {
                enabled             = true
                interval            = 30
                path                = var.health_check.path
                port                = port
                healthy_threshold   = var.health_check.healthy_threshold
                unhealthy_threshold = var.health_check.unhealthy_threshold
                timeout             = var.health_check.timeout
                protocol            = contains(var.port_external_https, port) ? "HTTPS" : "HTTP"
                matcher             = var.health_check.matcher
            }
        }
    ]
    
    http_tcp_listeners = [
        for port in local.external_ports:
        {
            port: port,
            protocol: "HTTP",
            target_group_index: index(local.external_ports, port)
        }
        if contains(var.port_external_https, port) == false
    ]
    https_listeners = [
        for port in local.external_ports:
        {
            port: port,
            protocol: "HTTPS",
            target_group_index: index(local.external_ports, port)
            certificate_arn: var.port_external_https_certificate_arn
        }
        if contains(var.port_external_https, port)
    ]
}