module "project-services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "~> 12.0"

  project_id = var.project_id
  # enable_apis = var.enable_apis

  activate_apis = [
    "iam.googleapis.com",
    "clouddeploy.googleapis.com",
    "run.googleapis.com"
  ]
  disable_services_on_destroy = false
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}