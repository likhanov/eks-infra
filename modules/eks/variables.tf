variable "environment" {
  description = "Deployment environment (dev, prod)"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Version of the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the EKS cluster will be deployed"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs within the VPC for EKS worker nodes"
  type        = list(string)
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
