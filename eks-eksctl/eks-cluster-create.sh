eksctl create cluster -f cks-prep-cluster.yaml

eksctl utils write-kubeconfig --cluster=cks-prep-cluster --region=us-east-1


# https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html
# https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html

