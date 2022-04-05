variable "project" {
  type = string
  description = "Google Cloud project name"
}

variable "machine_type" {
  type = string
  description = "Machine type to use for the general-purpose node pool. See https://cloud.google.com/compute/docs/machine-types"
  default = "e2-small"
}

variable "cluster_name" {
  type = string
  description = "Name of your cluster in GKE"
  default = "k8s-test-cluster"
}

variable "region" {
  type = string
  description = "Google Cloud region check https://cloud.google.com/compute/docs/regions-zones/"
  default = "us-central1"
}

variable "zone" {
  type = string
  description = "Google Cloud zone check https://cloud.google.com/compute/docs/regions-zones/"
  default = "us-central1-c"
}

variable "network_name" {
  type = string
  description = "network name for GKE cluster"
  default = "k8s-network-test"
}

variable "credentials" {
  type = string
  description = "Credentials path (account service json path) use the auth path and refer it"
}