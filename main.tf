module "network" {
  source               = "./modules/network"
  name                 = "core-network"
  vpc_cidr             = "10.0.0.0/16"
  azs                  = ["ap-south-1a", "ap-south-1b"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
  db_subnet_cidrs      = ["10.0.21.0/24", "10.0.22.0/24"]
}

module "security_groups" {
  source = "./modules/security-groups"
  name   = "core-network"
  vpc_id = module.network.vpc_id
}

module "alb" {
  source            = "./modules/alb"
  name              = "core-network"
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
  alb_sg_id         = module.security_groups.alb_sg_id
}

module "compute" {
  source             = "./modules/compute"
  name               = "core-network"
  private_subnet_ids = module.network.private_subnet_ids
  app_sg_id          = module.security_groups.app_sg_id
  target_group_arn   = module.alb.target_group_arn
}

module "database" {
  source        = "./modules/database"
  name          = "core-network"
  db_subnet_ids = module.network.db_subnet_ids
  db_sg_id      = module.security_groups.db_sg_id
}