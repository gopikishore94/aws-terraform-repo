output "vpc-id" {
  value = module.vpc.vpc_id
}
output "vpc-cidr_blocks" {
  value = module.vpc.vpc_cidr
}
output "public_subnets" {
  value = module.vpc.public_subnets
}
output "private_subnets" {
  value = module.vpc.private_subnets
}
output "aws_subnet_azs" {
  value = module.vpc.aws_subnet_azs
}
output "security_id" {
  value = module.public_security_group.security_id
}
output "public_instance_ids" {
  value = module.ec2.public_instance_ids
}
output "private_instances_ids" {
  value = module.ec2.private_instance_ids
}
output "target_group_arn" {
  value = module.clb.tg_arn
}
output "target_group_name" {
  value = module.clb.tg_arn_name
}
output "target_ids" {
  value = module.clb.target_output_id
}
output "load_balancer_arn" {
  value = module.clb.load_balancer_arn
}
output "load_balancer_dns" {
  value = module.clb.load_balancer_dns
}
output "asg_lc_name" {
  value = module.auto_scaling.launch_configuration_name
}
output "launch_configuration_image_id" {
  value = module.auto_scaling.launch_configuration_image
}
output "ami_backup_id" {
  value = module.ami_module.ami_name_asg_name
}