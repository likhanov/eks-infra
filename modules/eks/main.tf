module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.23.0"

  cluster_name                   = var.cluster_name
  cluster_version                = var.cluster_version
  cluster_endpoint_public_access = true

  cluster_addons = {
    kube-proxy = { most_recent = true }
    coredns    = { most_recent = true }

    vpc-cni = {
      most_recent    = true
      before_compute = true
      configuration_values = jsonencode({
        env = {
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }
  }

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  create_cloudwatch_log_group              = false
  create_cluster_security_group            = false
  create_node_security_group               = false
  authentication_mode                      = "API_AND_CONFIG_MAP"
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    control_apps = {
      node_group_name = "managed-ondemand"
      instance_types  = ["t2.micro", "t3.micro"]

      create_security_group = false

      subnet_ids   = var.private_subnets
      max_size     = 2
      desired_size = 2
      min_size     = 2

      create_launch_template = true
      launch_template_os     = "amazonlinux2eks"

      labels = {
        intent = "control-apps"
      }
    }
  }

  tags = merge(var.common_tags, {
    "karpenter.sh/discovery" = var.cluster_name
  })
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
