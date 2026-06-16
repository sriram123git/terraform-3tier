provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source              = "../../modules/vpc"
  environment         = var.environment
  vpc_cidr            = "10.2.0.0/16"
  public_subnet_cidr  = "10.2.1.0/24"
  private_subnet_cidr = "10.2.2.0/24"
}

module "sg" {
  source      = "../../modules/security-group"
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
}

module "ec2" {
  source        = "../../modules/ec2"
  environment   = var.environment
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnet_id
  sg_id         = module.sg.sg_id
}

module "alb" {
  source      = "../../modules/alb"
  environment = var.environment
  subnet_id   = module.vpc.public_subnet_id
  sg_id       = module.sg.sg_id
}

module "rds" {
  source            = "../../modules/rds"
  db_instance_class = var.db_instance_class
}
