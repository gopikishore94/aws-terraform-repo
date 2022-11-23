output "ami_name_asg_name"{
  value = aws_ami_from_instance.image_ami.id
}