variable "instance_type"{
  default = "t2.micro"
}
variable "asg_name_lc"{}
variable "image_id"{}
variable "asg_name"{}
variable "min_size"{}
variable "max_size"{}
variable "desired_capacity"{}
variable "key_name" {}
variable "security_groups"{}
//variable "availability_zones"{}
variable "load_balancers"{}
variable "vpc_zone_identifier"{}
variable "env"{}