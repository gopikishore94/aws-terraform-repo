# An example of target group
resource "aws_alb_target_group" "tg" {
  name      = var.target_name
  port      = var.target_port
  protocol  = var.target_protocol
  vpc_id    = var.vpc_id 

  health_check {
    path                = var.health_path
    port                = var.health_port
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = 2
    interval            = 5
    matcher             = "200"  # has to be HTTP 200 or fails
  }
}
resource "aws_lb_listener" "alb_listner" {
  load_balancer_arn = aws_lb.test.arn
  port              = 80
  protocol          = "HTTP"
 default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tg.arn
  }
}
resource "aws_lb" "test" {
  name               = var.aws_lb_name
  internal           = var.aws_lb_type
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnets


  tags = {
    Environment      = "production"
  }
}
resource "aws_lb_target_group_attachment" "target_attachment" {
  count            = length(var.target_id)
  target_group_arn = aws_alb_target_group.tg.arn
  target_id        = element(var.target_id, count.index)
  port             = 80
}