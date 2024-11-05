variable "region" {
  description = "AWS region for deploying resources"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
