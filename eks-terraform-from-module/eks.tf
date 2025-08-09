resource "random_string" "suffix" {
  length  = 4
  upper   = false
  lower   = true
  numeric = true
  special = false
}

locals {
  cluster_name = "${var.cluster_name}-${random_string.suffix.result}"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = ">= 21.0"
  kubernetes_version = "1.33"

  name    = local.cluster_name

  endpoint_private_access = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  enable_irsa = true

  create_kms_key                  = true
  kms_key_administrators          = [data.aws_caller_identity.current.arn]
  encryption_config = {
    resources        = ["secrets"]
    provider_key_arn = null
  }
  create_cloudwatch_log_group     = true 
  cloudwatch_log_group_retention_in_days = 30
  enabled_log_types       = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  addons = {
    coredns   = { most_recent = true }
    kube-proxy = { most_recent = true }
    vpc-cni   = { most_recent = true }
  }

  eks_managed_node_groups = {
    default = {
      ami_type       = "AL2023_x86_64_STANDARD"
      # ami_type       = "BOTTLEROCKET_x86_64"
      disk_size      = 50
      instance_types = var.node_instance_types
      subnet_ids     = module.vpc.private_subnets
        tags = {
        "k8s.io/cluster-autoscaler/enabled"      = "true"
        "k8s.io/cluster-autoscaler/${local.cluster_name}" = "owned"
        }
    }
  }

  # Optionally grant current caller admin cluster access
  enable_cluster_creator_admin_permissions = true
}


