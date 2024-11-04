variable "region" {
  description = "AWS region for deploying resources"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, prod)"
  type        = string
}

variable "project_name" {
  description = "Project name"
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
