resource "aws_ami_from_instance" "image_ami" {
  name               = var.ami_name_asg
  source_instance_id = var.source_instance_id

  tags = {
    Name = "${var.env}-AMI"
  }
}