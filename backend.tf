terraform {
  backend "s3" {
    bucket         = "mediterraneum-eks-terraform-state"
    key            = "terraform-eks.tfstate"
    region         = "us-east-1"
    dynamodb_table = "mediterraneum-eks-terraform-lock-id"
    encrypt        = true
  }
}
