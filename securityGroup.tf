resource "aws_security_group" "sg" {
    for_each = var.sg_list
    name = each.value.name
    description = each.value.description
    vpc_id = "vpc-0df873bd3e580bdf3"  #replace with your Vpc id#

    tags =  {
        Name = each.value.name
        Description = each.value.description
    }
}

# Ingress Rules Creation

resource "aws_security_group_rule" "ingress" {
    for_each = {
    for sg_name, sg in var.sg_list : sg_name => sg
    
  }

    type = "ingress"
    from_port         = each.value.ingress_fromport
    to_port           = each.value.ingress_toport
    protocol          = each.value.protocol
    cidr_blocks       = each.value.cidr_block
    description       = each.key
    security_group_id = aws_security_group.sg[each.key].id
}

# Egress Rules Creation

resource "aws_security_group_rule" "egress" {
    for_each = {
    for sg_name, sg in var.sg_list : sg_name => sg
    
  }

    type = "egress"
    from_port         = each.value.egress_fromport
    to_port           = each.value.egress_toport
    protocol          = each.value.protocol
    cidr_blocks       = each.value.cidr_block
    description       = each.key
    security_group_id = aws_security_group.sg[each.key].id
}
