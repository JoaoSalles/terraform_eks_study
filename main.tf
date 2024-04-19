module "new-vpc" {
    source = "./modules/vpc"
    prefix = var.prefix
    vpc_cidr = var.vpc_cidr__cidr_block
}

module "new-lb" {
    source = "./modules/lb"
    prefix = var.prefix
    subnet_ids = module.new-vpc.subnet_ids
    vpc_id = module.new-vpc.vpc_id

    depends_on = [ module.new-vpc ]
}

module "new-ec2-cluster" {
    source = "./modules/ec2"
    prefix = var.prefix
    subnet_ids = module.new-vpc.subnet_ids
    lb_target_group_arn = module.new-lb.lb_target_group_arn
    lb_sg_id = module.new-lb.lb_sg_id
    vpc_id = module.new-vpc.vpc_id

    depends_on = [ module.new-vpc, module.new-lb ]
}