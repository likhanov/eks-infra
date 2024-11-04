output "cluster_name" {
  description = "Name of the created EKS cluster"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint of the created EKS cluster"
  value       = module.eks.cluster_endpoint
}
