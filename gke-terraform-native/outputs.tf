output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "cluster_endpoint" {
  description = "Private endpoint is enabled; public endpoint may be null if disabled"
  value       = google_container_cluster.primary.endpoint
}

output "network" {
  value = google_compute_network.vpc.self_link
}

output "subnetwork" {
  value = google_compute_subnetwork.gke.self_link
}


