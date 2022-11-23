resource "aws_security_group" "allow_all" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id
 dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description      = lookup(ingress.value, "description", "")
      from_port        = lookup(ingress.value, "from_port", null)
      to_port          = lookup(ingress.value, "to_port", null)
      protocol         = lookup(ingress.value, "protocol", null)
      cidr_blocks      = lookup(ingress.value, "cidr_blocks", null)
    }
  }

  tags = {
    Name = "${var.env}-sg"
  }
}
