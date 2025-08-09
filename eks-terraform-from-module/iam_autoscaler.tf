# data "aws_iam_policy_document" "cluster_autoscaler_assume_role" {
#   statement {
#     actions = ["sts:AssumeRoleWithWebIdentity"]

#     principals {
#       type        = "Federated"
#       identifiers = [module.eks.oidc_provider_arn]
#     }

#     condition {
#       test     = "StringEquals"
#       variable = "${replace(module.eks.oidc_provider, "https://", "")}:sub"
#       values   = ["system:serviceaccount:kube-system:cluster-autoscaler"]
#     }

#     condition {
#       test     = "StringEquals"
#       variable = "${replace(module.eks.oidc_provider, "https://", "")}:aud"
#       values   = ["sts.amazonaws.com"]
#     }
#   }
# }

# data "aws_iam_policy_document" "cluster_autoscaler" {
#   statement {
#     sid    = "ClusterAutoscalerPolicy"
#     effect = "Allow"
#     actions = [
#       "autoscaling:DescribeAutoScalingGroups",
#       "autoscaling:DescribeAutoScalingInstances",
#       "autoscaling:DescribeLaunchConfigurations",
#       "autoscaling:DescribeTags",
#       "autoscaling:SetDesiredCapacity",
#       "autoscaling:TerminateInstanceInAutoScalingGroup",
#       "autoscaling:UpdateAutoScalingGroup",
#       "autoscaling:DescribeScalingActivities",
#       "ec2:DescribeImages",
#       "ec2:DescribeInstanceTypes",
#       "ec2:DescribeLaunchTemplateVersions",
#       "ec2:DescribeInstances",
#       "ec2:DescribeSubnets",
#       "ec2:DescribeInstanceTypeOfferings"
#     ]
#     resources = ["*"]
#   }
# }

# resource "aws_iam_policy" "cluster_autoscaler" {
#   name        = "${local.cluster_name}-cluster-autoscaler"
#   description = "EKS Cluster Autoscaler policy"
#   policy      = data.aws_iam_policy_document.cluster_autoscaler.json
# }

# resource "aws_iam_role" "cluster_autoscaler" {
#   name               = "${local.cluster_name}-cluster-autoscaler"
#   assume_role_policy = data.aws_iam_policy_document.cluster_autoscaler_assume_role.json
# }

# resource "aws_iam_role_policy_attachment" "cluster_autoscaler" {
#   role       = aws_iam_role.cluster_autoscaler.name
#   policy_arn = aws_iam_policy.cluster_autoscaler.arn
# }

# resource "kubernetes_service_account" "cluster_autoscaler" {
#   metadata {
#     name      = "cluster-autoscaler"
#     namespace = "kube-system"
#     annotations = {
#       "eks.amazonaws.com/role-arn" = aws_iam_role.cluster_autoscaler.arn
#     }
#   }
# }


