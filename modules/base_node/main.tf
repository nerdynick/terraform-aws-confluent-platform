provider "aws" {
    alias = "default"
}
provider "aws" {
    alias = "dns"
}

locals {
    volumes_to_mount = setproduct(range(var.servers), var.ebs_volumes)
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
    provider        = aws.default
    count           = var.servers
    ami             = var.image_id
    instance_type   = var.instance_type
    key_name        = var.key_pair
    subnet_id       = var.multi_az ? var.subnet_ids[(count.index%length(var.subnet_ids))] : element(var.subnet_ids, 0)
    vpc_security_group_ids = compact(var.security_group_ids)
    

    tags = merge(var.tags, { 
        "Name"=data.template_file.node_name[count.index].rendered
    })
    
    volume_tags = merge(var.tags, {
        "Name"=data.template_file.node_name[count.index].rendered
    })

    root_block_device {
        volume_size = var.root_volume_size
        delete_on_termination = true
        volume_type = "gp2"
    }
}

resource "aws_ebs_volume" "instance_volume" {
    provider        = aws.default
    count = length(local.volumes_to_mount)
    
    availability_zone = aws_instance.instance[local.volumes_to_mount[count.index][0]].availability_zone
    encrypted = local.volumes_to_mount[count.index][1].encrypted
    size = local.volumes_to_mount[count.index][1].size
    type = local.volumes_to_mount[count.index][1].type
    kms_key_id = local.volumes_to_mount[count.index][1].kms_key_id
    tags = merge(var.tags, local.volumes_to_mount[count.index][1].tags, {
        Name:  "${aws_instance.instance[local.volumes_to_mount[count.index][0]].tags["Name"]}-${local.volumes_to_mount[count.index][1].name}"
    })
}

resource "aws_volume_attachment" "instance_volume_attach" {
    provider        = aws.default
    count = length(local.volumes_to_mount)
    
    device_name = local.volumes_to_mount[count.index][1].device_name
    volume_id = aws_ebs_volume.instance_volume[count.index].id
    instance_id = aws_instance.instance[local.volumes_to_mount[count.index][0]].id
}

resource "aws_route53_record" "dns_record" {
    provider        = aws.dns
    count   = var.enable_dns_creation ? var.servers : 0
    zone_id = var.dns_zone_id
    name    = data.template_file.node_dns[count.index].rendered
    type    = "CNAME"
    ttl     = var.dns_ttl
    records = [element(aws_instance.instance.*.public_dns, count.index)]
}