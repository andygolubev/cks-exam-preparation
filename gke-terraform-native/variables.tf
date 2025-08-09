variable "network_name" {
  description = "VPC name"
  type        = string
  default     = "gke-secure-vpc"
}

variable "ip_range_pods" {
  description = "Secondary range for Pods"
  type        = string
  default     = "10.48.0.0/14"
}

variable "ip_range_services" {
  description = "Secondary range for Services"
  type        = string
  default     = "10.52.0.0/20"
}

variable "subnet_cidr" {
  description = "Primary subnet CIDR"
  type        = string
  default     = "10.0.0.0/20"
}

variable "cluster_name" {
  description = "GKE cluster name"
  type        = string
  default     = "gke-secure-cluster"
}

variable "master_ipv4_cidr_block" {
  description = "Control plane authorized RFC1918 block for private endpoint"
  type        = string
  default     = "172.16.0.0/28"
}

variable "control_plane_authorized_cidrs" {
  description = "List of CIDR blocks allowed to reach the public control plane endpoint (if enabled)"
  type        = list(object({
    cidr_block   = string
    display_name = string
  }))
  default = []
}

variable "min_node_count" {
  description = "Minimum nodes per node pool"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum nodes per node pool"
  type        = number
  default     = 3
}

variable "machine_type" {
  description = "GCE machine type"
  type        = string
  default     = "e2-standard-4"
}

variable "enable_control_plane_global_access" {
  description = "Allow private control plane to be reachable from on-prem and other regions"
  type        = bool
  default     = true
}

variable "enable_workload_identity" {
  description = "Enable Workload Identity"
  type        = bool
  default     = true
}

variable "enable_binary_authorization" {
  description = "Enforce Binary Authorization using project singleton policy"
  type        = bool
  default     = true
}


