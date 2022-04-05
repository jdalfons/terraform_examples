output "project" {
  value = var.project
}

output "check-credentials" {
    value = "Check your credentials 'kubectl config current-context' or configurate your context running 'gcloud container clusters get-credentials ${google_container_cluster.cluster.name} --zone=${var.zone} --project ${var.project}'"
}