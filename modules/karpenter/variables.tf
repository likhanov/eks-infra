variable "region" {
  description = "AWS region for deploying resources"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "node_iam_role_arn" {
  type = string
}

variable "cluster_endpoint" {
  type = string
}

variable "cluster_ca_certificate" {
  type = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
