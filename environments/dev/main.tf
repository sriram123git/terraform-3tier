provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source              = "../../modules/vpc"
  environment         = var.environment
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.3.0/24"
}

module "sg" {
  source      = "../../modules/security-group"
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
}

module "ec2" {
  source               = "../../modules/ec2"
  environment          = var.environment
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = module.vpc.public_subnet_1_id
  sg_id                = module.sg.sg_id
  iam_instance_profile = "MGN"
}

module "alb" {
  source = "../../modules/alb"

  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  public_subnet_1_id = module.vpc.public_subnet_1_id
  public_subnet_2_id = module.vpc.public_subnet_2_id

  sg_id       = module.sg.sg_id
  instance_id = module.ec2.instance_id
}

module "rds" {
  source            = "../../modules/rds"
  db_instance_class = var.db_instance_class
}
