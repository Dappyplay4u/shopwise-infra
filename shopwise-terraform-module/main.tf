locals {
  region        = var.region
  project_name  = var.project_name
  environment   = var.environment
}

# Create VPC module
module "vpc" {
  source                        = "https://github.com/Dappyplay4u/shopwise-infra.git//shopwise-terraform-module//vpc/"
  region                        = local.region
  project_name                  = local.project_name
  environment                   = local.environment
  vpc_cidr                      = var.vpc_cidr
  public_subnet_az1_cidr        = var.public_subnet_az1_cidr
  public_subnet_az2_cidr        = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr   = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr   = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr  = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr  = var.private_data_subnet_az2_cidr
}

# Create Natgate way Module
module "nat_gateway" {
  source                        = "https://github.com/Dappyplay4u/shopwise-infra.git//shopwise-terraform-module//nat-gateway/"
  project_name                  = local.project_name
  environment                   = local.environment
  public_subnet_az1_id          = module.vpc.public_subnet_az1_id
  public_subnet_az2_id          = module.vpc.public_subnet_az2_id
  private_app_subnet_az1_id     = module.vpc.public_subnet_az2_id
  private_app_subnet_az2_id     = module.vpc.private_app_subnet_az2_id
  private_data_subnet_az1_id    = module.vpc.private_data_subnet_az1_id
  private_data_subnet_az2_id    = module.vpc.private_data_subnet_az2_id
  internet_gateway              = module.vpc.internet_gateway
  vpc_id                        = module.vpc.vpc_id
}

# Create Security Group Module
module "security_group" {
  source                        = "https://github.com/Dappyplay4u/shopwise-infra.git//shopwise-terraform-module//security-group/"
  project_name                  = local.project_name
  environment                   = local.environment
  vpc_id                        = module.vpc.vpc_id
  ssh_ip                        = var.ssh_ip
}

# RDS Group module
module "rds" {
  source                        = "https://github.com/Dappyplay4u/shopwise-infra.git//shopwise-terraform-module//rds/"
  project_name                  = local.project_name
  environment                   = local.environment
  private_data_subnet_az1_id    = module.vpc.private_data_subnet_az1_id
  private_data_subnet_az2_id    = module.vpc.private_data_subnet_az2_id
  database_instance_class       = var.database_instance_class
  db_name                       = var.db_name
  db_username                   = var.username
  db_password                   = var.password
  database_security_group_id    = module.security_group.database_security_group_id
  availability_zone_1           = module.vpc.availability_zone_1
  multi_az_deployment           = var.multi_az_deployment
}