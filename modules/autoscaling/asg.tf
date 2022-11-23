resource "aws_launch_configuration" "lc" {
  name            = var.asg_name_lc
  image_id        = var.image_id
  security_groups = var.security_groups
  instance_type   = var.instance_type
  key_name        = var.key_name

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "asg" {
  name                 = var.asg_name
  launch_configuration = aws_launch_configuration.lc.name
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  vpc_zone_identifier  = var.vpc_zone_identifier
  load_balancers      = var.load_balancers
  lifecycle {
    create_before_destroy = true
  }
}
