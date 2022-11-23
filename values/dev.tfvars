region                 = "ap-south-1"
vpc_cidr               = "10.0.0.0/16"
public_cidrs           = ["10.0.1.0/24", "10.0.2.0/24"]
private_cidrs          = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
azs                    = ["ap-south-1a", "ap-south-1b"]
env                    = "dev"
public_instance_count  = 1
private_instance_count = 1
public_instance_type   = "t2.micro"
private_instance_type  = "t2.micro"
key_name               = "mumbai"
########## SG #########
sg_name                = "ssh_security_group"
public_sg_description  = "allow from local"
private_sg_description = "allow from vpc"
ingress_rules = [
    {
        description = "testing-sg"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    },
        {
        description = "dev-sg"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
]
########### lb values ##############
healthy_threshold   = 2
unhealthy_threshold = 5
target_name         = "public-tg"
target_port         = 80
target_protocol     = "HTTP"
load_balancer_type  = "application"
aws_lb_name         = "testing-lb"
aws_lb_type         = false
//target_type         = "instance"

####### asg values ##########
asg_name         = "onlineshop_asg"
asg_name_lc      = "onlineshop_asg_lc"
min_size         = 1
max_size         = 5
desired_capacity = 2
ami_name_asg     = "AMI from Private_EC2"
