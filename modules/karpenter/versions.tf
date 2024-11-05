terraform {
  required_version = "~> 1.9"
  
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.7"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.1.2"
    }
  }
}
