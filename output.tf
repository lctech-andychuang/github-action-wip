output "oidc" {
  value = module.oidc
}

output "gihtub_sa_email" {
  value = google_service_account.github-action.email
}

output "gcr_id" {
  value = google_artifact_registry_repository.repo.id
}
