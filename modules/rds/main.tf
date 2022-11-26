resource "aws_db_instance" "rds_db" {
  allocated_storage    = var.rds_allocated_storage
  db_name              = var.rds_db_name
  engine               = var.rds_engine
  engine_version       = var.rds_engine_version
  instance_class       = var.rds_instance_class
  username             = var.rds_username
  password             = var.rds_password
  parameter_group_name = var.rds_parameter_group_name
  skip_final_snapshot  = var.rds_skip_final_snapshot
}