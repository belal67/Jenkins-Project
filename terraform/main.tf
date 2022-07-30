

module "network" {
    source = "./network"   
    cidr_vpc = var.vpc
    cidr_public1  = var.public1
    cidr_public2 = var.public2 
    cidr_private1 = var.private1
    cidr_private2 = var.private2
    region  = var.region
    # providers = {
    #   aws = aws.central
    #  }
}