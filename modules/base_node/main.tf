locals {
    num_lb_target = length(var.lb_target_groups)
    lb_inst_product = setproduct(range(0,var.servers),var.lb_target_groups) 
}

data "template_file" "node_name" {
    count           = var.servers
    template        = var.name_template
    
    vars = merge(var.extra_template_vars, {
        "itemcount" = "${count.index+1}"
    })
}
data "template_file" "node_dns" {
    count           = var.servers
    template        = var.dns_template
    vars = merge(var.extra_template_vars, {
        "itemcount" = "${count.index+1}"
        "name" = data.template_file.node_name[count.index].rendered
    })
}
resource "aws_instance" "instance" {
    count           = var.servers
    ami             = var.image_id
    instance_type   = var.instance_type
    key_name        = var.key_pair
    subnet_id       = var.subnet_id
    vpc_security_group_ids = var.security_groups_ids
    

    tags = merge(var.tags, {
        "name"=data.template_file.node_name[count.index].rendered, 
        "Name"=data.template_file.node_name[count.index].rendered
    })
    
    volume_tags = merge(var.tags, {
        "name"=data.template_file.node_name[count.index].rendered, 
        "Name"=data.template_file.node_name[count.index].rendered
    })

    root_block_device {
        volume_size = var.root_volume_size
        delete_on_termination = true
    }
}

resource "aws_route53_record" "dns_record" {
    count   = var.enable_dns_creation ? var.servers : 0
    zone_id = var.dns_zone_id
    name    = data.template_file.node_dns[count.index].rendered
    type    = "CNAME"
    ttl     = var.dns_ttl
    records = [element(aws_instance.instance.*.public_dns, count.index)]
}

resource "aws_lb_target_group_attachment" "lb_group" {
    count               = length(local.lb_inst_product)
    
    target_group_arn    = element(local.lb_inst_product, count.index)[1]
    target_id           = element(aws_instance.instance.*.id, element(local.lb_inst_product, count.index)[0])
}