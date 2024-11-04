terraform {
  required_version = "~> 1.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.33"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.1.2"
    }
  }
}
