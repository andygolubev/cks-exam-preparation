locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = ">= 5.8"

  name = "${var.project}-${var.environment}-vpc"
  cidr = var.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, az in local.azs : cidrsubnet(var.vpc_cidr, 4, k)]
  public_subnets  = [for k, az in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 48)]

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_flow_log           = true
  flow_log_destination_type = "cloud-watch-logs"
  flow_log_traffic_type     = "ALL"

  # Create required resources for CloudWatch flow logs delivery
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_cloudwatch_log_group_name_suffix        = "${var.project}-${var.environment}"
  flow_log_cloudwatch_log_group_retention_in_days  = 30

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}


