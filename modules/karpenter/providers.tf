provider "aws" {
  region = var.region
  alias  = "virginia"
}

provider "aws" {
  region = var.region
}

provider "helm" {
  kubernetes {
    host                   = var.cluster_name
    cluster_ca_certificate = var.cluster_ca_certificate

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    }
  }
}

provider "kubectl" {
  apply_retry_count      = 10
  host                   = var.cluster_endpoint
  cluster_ca_certificate = var.cluster_ca_certificate
  load_config_file       = false

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
  }
}