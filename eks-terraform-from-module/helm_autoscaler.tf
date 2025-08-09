# resource "helm_release" "cluster_autoscaler" {
#   name       = "cluster-autoscaler"
#   repository = "https://kubernetes.github.io/autoscaler"
#   chart      = "cluster-autoscaler"
#   namespace  = "kube-system"

#   create_namespace = false

#   depends_on = [kubernetes_service_account.cluster_autoscaler]

#   # Pin to a version matching the cluster (e.g., 1.29.x)
#   version = "9.46.0"

#   set {
#     name  = "autoDiscovery.clusterName"
#     value = module.eks.cluster_name
#   }

#   set {
#     name  = "awsRegion"
#     value = var.aws_region
#   }

#   set {
#     name  = "rbac.serviceAccount.create"
#     value = "false"
#   }

#   set {
#     name  = "rbac.serviceAccount.name"
#     value = kubernetes_service_account.cluster_autoscaler.metadata[0].name
#   }

#   set {
#     name  = "extraArgs.balance-similar-node-groups"
#     value = "true"
#   }

#   set {
#     name  = "extraArgs.skip-nodes-with-system-pods"
#     value = "false"
#   }

#   set {
#     name  = "extraArgs.skip-nodes-with-local-storage"
#     value = "false"
#   }

#   set {
#     name  = "image.tag"
#     value = "v1.29.0"
#   }
# }


