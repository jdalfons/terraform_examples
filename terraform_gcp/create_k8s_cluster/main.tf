terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

# use provider "google-beta" fot beta arguments in https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
provider "google-beta" {
  # Google service accounts IAM Roles in README.md.
  credentials = file(var.credentials)

  project = var.project
  region  = var.region
  zone    = var.zone
}

data "google_container_engine_versions" "default" {
  location  = var.zone
  project   = var.project
}

# Create cluster
resource "google_container_cluster" "cluster" {
  name               = var.cluster_name
  project             = var.project 
  location           = var.zone
  enable_legacy_abac = true
  initial_node_count = var.node_count
  min_master_version = data.google_container_engine_versions.default.latest_master_version

  node_config {
    preemptible  = true
    machine_type = var.machine_type

    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  # Remove default pods and create more pods with google_container_node_pool
  # remove_default_node_pool = true
  
  addons_config {
    # disable load balancing
    #
    # http_load_balancing {
    #   disabled = true
    # }

    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  # # Vertical autoscaling Beta in ver 1.19.0
  vertical_pod_autoscaling {
    enabled = true
  }

  # # Set horizontal vertical or autoscaling disable in true to autoscaling cluster
  
  # # EXAMPLE
  
  cluster_autoscaling {
    enabled = true
    # Resource limits based in https://cloud.google.com/kubernetes-engine/docs/how-to/node-auto-provisioning
    # Can use CPU (max - min cores) or memory (min - max number of gigabytes)
    resource_limits {
      resource_type = "cpu"
      minimum = 1
      maximum = 4
    }
    resource_limits {
      resource_type = "memory"
      minimum = 4
      maximum = 64
    }
    auto_provisioning_defaults {
      oauth_scopes    = [
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
        "https://www.googleapis.com/auth/devstorage.read_only"
      ]
    }
  }
}

# # Create more nodes with google_container_node_pool

# resource "google_container_node_pool" "primary_preemptible_nodes" {
#   name       = "${var.cluster_name}-node-pool"
#   location   = var.zone
#   cluster    = google_container_cluster.cluster.name
#   node_count = var.node_count

#   node_config {
#     preemptible  = true
#     machine_type = var.machine_type

#     oauth_scopes    = [
#       "https://www.googleapis.com/auth/cloud-platform"
#     ]
#   }
# }

# Getting cluster credentials
resource "null_resource" "get-credentials" {

 depends_on = [google_container_cluster.cluster] 
 
 provisioner "local-exec" {
   command = "gcloud container clusters get-credentials ${google_container_cluster.cluster.name} --zone=${var.zone} --project ${var.project}"
 }
}