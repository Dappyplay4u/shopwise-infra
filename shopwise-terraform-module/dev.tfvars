region                       = "us-west-2"
project_name                 = "shopwise"
environment                  = "dev"
vpc_cidr                     = "10.0.0.0/16"
public_subnet_az1_cidr       = "10.0.0.0/24"
public_subnet_az2_cidr       = "10.0.1.0/24"
private_app_subnet_az1_cidr  = "10.0.2.0/24"
private_app_subnet_az2_cidr  = "10.0.3.0/24"
private_data_subnet_az1_cidr = "10.0.4.0/24"
private_data_subnet_az2_cidr = "10.0.5.0/24"

# security group Variable
ssh_ip = "108.194.66.148/32" # type get my ip address on google

# RDS variables
database_instance_class = "db.t2.micro"
db_name                 = "shopwisedb"
db_username             = "shopwise"
db_password             = "shopwise123"
multi_az_deployment     = "false"