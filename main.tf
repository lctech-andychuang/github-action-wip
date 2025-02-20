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

resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = "cloud-run-artifacts"
  description   = "docker repository"
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }
}

resource "google_service_account" "github-action" {
  account_id   = "github-action-sa"
  display_name = "Github Service Account"
}

# note this requires the terraform to be run regularly
resource "time_rotating" "mykey_rotation" {
  rotation_days = 30
}

# Cloud Run Admin (roles/run.admin) or Cloud Run Developer (roles/run.developer).
# Storage Admin (roles/storage.admin) or Storage Object Admin (roles/storage.objectAdmin) if using Artifact Registry, or Container Registry Admin (roles/containerregistry.admin) if using GCR.
# You may need to add more roles depending on what other GCP resources you need to interact with during deployment.
resource "google_project_iam_member" "name" {
  for_each = toset([
    "roles/run.admin",
    "roles/storage.admin",
    "roles/artifactregistry.writer",
    "roles/iam.serviceAccountTokenCreator",
    "roles/iam.serviceAccountUser",
    "roles/clouddeploy.admin",
  ])
  project = var.project_id
  role    = each.key
  member  = google_service_account.github-action.member
}

module "oidc" {
  source  = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  version = "~> 4.0"

  project_id          = var.project_id
  pool_id             = "${var.oidc_name}-pool"
  provider_id         = "${var.oidc_name}-provider"
  attribute_condition = <<EOT
    assertion.ref_type == "branch" &&
    assertion.repository_owner == "${var.repo_owner}" &&
  EOT

  issuer_uri          = "https://token.actions.githubusercontent.com"

  sa_mapping = {
    (google_service_account.github-action.account_id) = {
      sa_name   = google_service_account.github-action.name
      attribute = "*"
    }
  }
}

