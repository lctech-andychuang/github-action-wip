# GCP project ID
variable "project_id" {
  type = string
}

# Used region for regional resources
variable "region" {
  type = string
}

variable "repo_owner" {
  type = string
}

variable "oidc_name" {
  type    = string
  default = null
}


