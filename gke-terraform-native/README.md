## Secure GKE cluster with Terraform (native resources)

Creates a private, regional GKE cluster with strong defaults:

- Private nodes, private control plane range
- VPC/subnet with secondary ranges for Pods/Services
- Cloud NAT for egress
- Workload Identity, Shielded Nodes, legacy metadata disabled
- Dataplane v2 + NetworkPolicy
- Binary Authorization (project policy) enabled

### Prereqs

- Terraform >= 1.5
- gcloud authenticated; ADC available
- Enable APIs (auto-enabled via resources): compute, container, iamcredentials, binaryauthorization

### Usage

```bash
export TF_VAR_project_id="YOUR_PROJECT_ID"
export TF_VAR_region="us-central1"

terraform init
terraform plan -out tfplan
terraform apply tfplan
```

Get kubeconfig (if you allow public control plane access or via private connectivity):

```bash
gcloud container clusters get-credentials gke-secure-cluster \
  --region "$TF_VAR_region" --project "$TF_VAR_project_id"
```

### Cleanup

```bash
terraform destroy
```


