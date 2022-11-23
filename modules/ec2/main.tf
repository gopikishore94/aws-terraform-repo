resource "aws_instance" "public_ec2" {
  count                  = var.public_instance_count
  ami                    = var.ami
  instance_type          = var.public_instance_type
  key_name               = var.key_name
  user_data              = var.user_data
  subnet_id              = element(var.public_subnet_id, count.index)
  vpc_security_group_ids = var.vpc_security_group_ids
  tags = {
    Name = "${var.env}-public-${count.index + 1}"
  }
}

resource "aws_instance" "private_ec2" {
  count                  = var.private_instance_count
  ami                    = var.ami
  instance_type          = var.private_instance_type
  key_name               = var.key_name
  user_data              = var.user_data
  subnet_id              = element(var.private_subnet_id, count.index)
  vpc_security_group_ids = var.vpc_security_group_ids
  tags = {
    Name = "${var.env}-private-${count.index + 1}"
  }
}
