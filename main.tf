module "eks" {
  source = "./modules/eks"

  environment     = var.environment
  cluster_name    = var.project_name
  cluster_version = var.cluster_version
  vpc_id          = var.vpc_id
  private_subnets = var.private_subnets
  tags = {
    Project     = var.project_name
    Environment = var.environment
    Managed-by  = "terraform"
  }
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}