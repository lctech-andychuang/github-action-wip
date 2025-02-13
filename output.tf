output "oidc" {
  value = module.oidc
}

output "gihtub_sa" {
  value = google_service_account.github-action.email
}

data "google_project" "project" {
}

output "project" {
  value = data.google_project.project
}

output "gcr_id" {
  value = google_artifact_registry_repository.repo.id
}