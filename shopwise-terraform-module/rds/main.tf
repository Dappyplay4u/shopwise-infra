# create database subnet group
resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "${var.project_name}-${var.environment}-database-subnets"
  subnet_ids  = [var.private_data_subnet_az1_id, var.private_data_subnet_az2_id]
  description = "subnets for database instance"

  tags = {
    Name = "${var.project_name}-${var.environment}-database-subnets"
  }
}

# Create a new RDS instance (not from a snapshot)
resource "aws_db_instance" "database_instance" {
  identifier              = "${var.project_name}-${var.environment}-rds"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = var.database_instance_class
  name                    = var.db_name
  username                = var.db_username
  password                = var.db_password
  parameter_group_name    = "default.mysql8.0"
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids  = [var.database_security_group_id]
  multi_az                = var.multi_az_deployment
  publicly_accessible     = false
  availability_zone       = var.availability_zone_1

  tags = {
    Name = "${var.project_name}-${var.environment}-rds"
  }
}


# # get information about a database snapshot
# data "aws_db_snapshot" "latest_db_snapshot" {
#   db_snapshot_identifier = 
#   most_recent            = 
#   snapshot_type          = 
# }

# # launch an rds instance from a database snapshot
# resource "aws_db_instance" "database_instance" {
#   instance_class         = 
#   skip_final_snapshot    = 
#   availability_zone      = 
#   identifier             = 
#   snapshot_identifier    = 
#   db_subnet_group_name   = 
#   multi_az               = 
#   vpc_security_group_ids = 
# }