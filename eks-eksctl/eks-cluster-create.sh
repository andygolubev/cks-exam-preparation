eksctl create cluster -f cks-prep-cluster.yaml

# eksctl upgrade cluster -f cks-prep-cluster.yaml

eksctl utils write-kubeconfig --cluster=cks-prep-cluster --region=us-east-1


# https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html
# https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html

# aws ssm start-session --target <instance-id>

aws ec2 describe-instances \
  --region us-east-1 \
  --filters "Name=tag:eks:cluster-name,Values=cks-prep-cluster" \
            "Name=instance-state-name,Values=running" \
  --query "Reservations[].Instances[].InstanceId" \
  --output text
