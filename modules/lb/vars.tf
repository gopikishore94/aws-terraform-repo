variable "target_name" {}
variable "target_port" {}
variable "target_protocol" {}
variable "vpc_id" {}
variable "health_path" {}
variable "health_port" {}
variable "healthy_threshold" {}
variable "unhealthy_threshold" {}
variable "subnets"{}
variable "security_groups" {}
variable "target_id" {}
variable "load_balancer_type"{}
variable "aws_lb_name"{}
variable "aws_lb_type"{
  type = bool
}