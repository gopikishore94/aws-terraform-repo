output "launch_configuration_name"{
  value = aws_launch_configuration.lc.name
}
output "launch_configuration_image"{
  value = aws_launch_configuration.lc.id
}