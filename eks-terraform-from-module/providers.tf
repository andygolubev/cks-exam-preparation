provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}

# # These providers will be configured after EKS cluster is created using data sources
# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.this.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
#   token                  = data.aws_eks_cluster_auth.this.token
# }

# provider "helm" {
#   kubernetes {
#     host                   = data.aws_eks_cluster.this.endpoint
#     cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
#     token                  = data.aws_eks_cluster_auth.this.token
#   }
# }


