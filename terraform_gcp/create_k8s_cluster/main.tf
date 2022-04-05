terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)

  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "default" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
  name                     = var.network_name
  ip_cidr_range            = "10.0.0.0/24"
  network                  = google_compute_network.default.self_link
  region                   = var.region
  private_ip_google_access = true
}

data "google_client_config" "current" {
}

data "google_container_engine_versions" "default" {
  location = var.zone
}

# Create cluster
resource "google_container_cluster" "cluster" {
  name               = var.cluster_name
  location           = var.zone
  initial_node_count = 2
  min_master_version = data.google_container_engine_versions.default.latest_master_version
  network            = google_compute_subnetwork.default.name
  subnetwork         = google_compute_subnetwork.default.name

  enable_legacy_abac = true
  node_config {
    machine_type = var.machine_type
  }

}

# Getting cluster credentials
resource "null_resource" "get-credentials" {

 depends_on = [google_container_cluster.cluster] 
 
 provisioner "local-exec" {
   command = "gcloud container clusters get-credentials ${google_container_cluster.cluster.name} --zone=${var.zone} --project ${var.project}"
 }
}