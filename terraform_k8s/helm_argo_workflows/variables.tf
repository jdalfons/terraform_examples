variable "argo_namespace" {
    type = string
    description = "Argo workflows namespace"
    default = "argo"
}

variable "helm_release_name" {
  type = string
  default = "argo-workflows"
}

variable "helm_chart" {
  type = string
  default = "argo-workflows"
}

variable "helm_repository" {
  type = string
  default = "https://argoproj.github.io/argo-helm"
}

variable "helm_repository_password" {
  type = string
  default = ""
}

variable "helm_repository_username" {
  type = string
  default = ""
}

variable "chart_version" {
  type = string
  default = "0.8.0"
}

variable "values" {
  type = string
  default = ""
}


