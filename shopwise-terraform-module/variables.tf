# Environmental Variable
variable "region" {}
variable "project_name" {}
variable "environment" {}

# vpc Variables
variable "vpc_cidr" {}
variable "public_subnet_az1_cidr" {}
variable "public_subnet_az2_cidr" {}
variable "private_app_subnet_az1_cidr" {}
variable "private_app_subnet_az2_cidr" {}
variable "private_data_subnet_az1_cidr" {}
variable "private_data_subnet_az2_cidr" {}
variable "ssh_ip" {}

# RDS variables
variable "database_instance_class" {}
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}
variable "multi_az_deployment" {}