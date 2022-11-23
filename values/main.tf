module "vpc" {
  source        = "../modules/vpc"
  vpc_cidr      = var.vpc_cidr
  env           = var.env
  public_cidrs  = var.public_cidrs
  private_cidrs = var.private_cidrs
  azs           = var.azs
}

module "public_security_group" {
  source              = "../modules/securitygroup"
  sg_name             = var.sg_name
  sg_description      = var.public_sg_description
  vpc_id              = module.vpc.vpc_id
  env                 = var.env
  ingress_rules       = var.ingress_rules
}
#module "private_security_group" {
#  source         = "../modules/securitygroup"
#  sg_name        = var.sg_name
#  sg_description = var.private_sg_description
#  vpc_id         = module.vpc.vpc_id
#  env            = var.env
#  from_port      = var.private_from_port
#  to_port        = var.private_to_port
#  protocol       = var.private_protocol
#  cidr_blocks    = [module.vpc.vpc_cidr]
#}

module "ec2" {
  depends_on             = [module.vpc]
  source                 = "../modules/ec2"
  public_instance_count  = var.public_instance_count
  private_instance_count = var.private_instance_count
  public_instance_type   = var.public_instance_type
  private_instance_type  = var.private_instance_type
  key_name               = var.key_name
  public_subnet_id       = module.vpc.public_subnets
  private_subnet_id      = module.vpc.private_subnets
  vpc_security_group_ids = [module.public_security_group.security_id]
  env                    = var.env
  ami                    = data.aws_ami.app_ami.id
  user_data              = file("${path.module}/shell.sh")
}

module "clb" {
  source              = "../modules/lb"
  load_balancer_type  = var.load_balancer_type
  aws_lb_name         = var.aws_lb_name
  aws_lb_type         = var.aws_lb_type
  healthy_threshold   = var.healthy_threshold
  unhealthy_threshold = var.unhealthy_threshold
  vpc_id              = module.vpc.vpc_id
  target_name         = var.target_name
  target_port         = var.target_port
  health_path         = "/"
  health_port         = 80
  target_protocol     = var.target_protocol
  target_id           = module.ec2.private_instance_ids
  subnets = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1]
  ]
  security_groups = [module.public_security_group.security_id]
}
module "ami_module" {
  source             = "../modules/ami"
  ami_name_asg       = var.ami_name_asg
  source_instance_id = module.ec2.private_instance_ids[0]
  env                = var.env
}
module "auto_scaling" {
  source           = "../modules/autoscaling"
  depends_on       = [module.ec2]
  asg_name         = var.asg_name
  asg_name_lc      = var.asg_name_lc
  max_size         = var.max_size
  min_size         = var.min_size
  desired_capacity = var.desired_capacity
  security_groups  = [module.public_security_group.security_id]
  key_name         = var.key_name
  env              = var.env
  image_id         = module.ami_module.ami_name_asg_name
  load_balancers   = [module.clb.tg_arn]
  vpc_zone_identifier = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1]
  ]
}
