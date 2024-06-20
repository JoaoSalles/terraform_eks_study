module "new-vpc" {
    source = "./modules/vpc"
    prefix = var.prefix
    vpc_cidr = var.vpc_cidr__cidr_block
    availability_zones = var.availability_zones
}

module "new-lb" {
    source = "./modules/lb"
    prefix = var.prefix
    subnet_ids = module.new-vpc.subnet_ids
    vpc_ip = var.vpc_cidr__cidr_block
    vpc_id = module.new-vpc.vpc_id
    depends_on = [ module.new-vpc ]
}

module "new-ec2-cluster" {
    source = "./modules/ec2"
    prefix = var.prefix
    subnet_ids = module.new-vpc.subnet_ids
    lb_target_group_arn = module.new-lb.lb_target_group_arn
    lb_sg_id = module.new-lb.lb_sg_id
    lb_url = module.new-lb.app_url
    vpc_id = module.new-vpc.vpc_id
    depends_on = [ module.new-vpc, module.new-lb ]
}

module "backend-ec2-cluster" {
    source = "./modules/backend-service"
    aws_ecs_cluster_id = module.new-ec2-cluster.aws_ecs_cluster_id
    sg_public_id = module.new-ec2-cluster.sg_public_id
    prefix = var.prefix
    subnet_ids = module.new-vpc.pvt-subnets
    lb_target_group_arn = module.new-lb.lb_target_group_arn_private
    lb_sg_id = module.new-lb.lb_sg_id
    vpc_id = module.new-vpc.vpc_id
    depends_on = [ module.new-vpc, module.new-lb ]
}