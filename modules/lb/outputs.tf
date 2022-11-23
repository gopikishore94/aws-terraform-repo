output "tg_arn" {
    value = aws_alb_target_group.tg.arn
}
output "tg_arn_name" {
    value = aws_alb_target_group.tg.name
}
output "target_output_id" {
    value = aws_lb_target_group_attachment.target_attachment.*.id
}
output "load_balancer_arn" {
    value = aws_lb.test.arn
}
output "load_balancer_dns" {
    value = aws_lb.test.dns_name
}