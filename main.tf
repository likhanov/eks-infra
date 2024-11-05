locals {
  tags = {
    Project     = var.project_name
    Environment = var.environment
    Managed-by  = "terraform"
  }
}

################################################################################
# EKS Module
################################################################################

module "eks" {
  source = "./modules/eks"

  environment     = var.environment
  cluster_name    = var.project_name
  cluster_version = var.cluster_version
  vpc_id          = var.vpc_id
  private_subnets = var.private_subnets
  tags            = local.tags
}

################################################################################
# Karpenter
################################################################################

module "karpenter" {
  source = "./modules/karpenter"

  region = var.region
  tags   = local.tags
}