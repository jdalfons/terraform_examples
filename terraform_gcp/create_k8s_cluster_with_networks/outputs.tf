output "project" {
  value = var.project
}

output "check-credentials" {
    value = "Check your credentials running following command 'kubectl config current-context' if your need configurate your context again run gcloud container clusters get-credentials ${google_container_cluster.cluster.name} --zone=${var.zone} --project ${var.project}"
}