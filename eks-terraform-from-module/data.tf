data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

# Discover current public IP to optionally restrict cluster endpoint access
data "http" "current_ip" {
  url = "https://checkip.amazonaws.com/"
}

# After cluster creation, these are used by providers and helm
data "aws_eks_cluster" "this" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}


