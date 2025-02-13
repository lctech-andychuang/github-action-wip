# GCP Workload Identity Pool Setup for GitHub Actions

This repository contains Terraform configurations to set up a Google Cloud Platform (GCP) Workload Identity Pool. This setup allows GitHub Actions to authenticate with GCP securely without using long-lived service account keys.

## Repository Structure

```
.
├── main.tf        # Defines the core resources for the workload identity pool
├── output.tf      # Outputs relevant values after Terraform execution
├── providers.tf   # Specifies provider configurations
└── variables.tf   # Defines configurable input variables
```

## Prerequisites

- Google Cloud Project with sufficient permissions to create IAM policies
- Terraform installed
- `gcloud` CLI installed and authenticated

## Setup Instructions

1. **Clone the repository:**
   ```sh
   git clone github-action-wip
   cd github-action-wip
   ```

2. **Initialize Terraform:**
   ```sh
   terraform init
   ```

3. **Review and update variables:**
   Edit `variables.tf` or create a `terraform.tfvars` file with appropriate values.

4. **Apply the Terraform configuration:**
   ```sh
   terraform apply
   ```
   This will create the necessary Workload Identity Pool and Provider for GitHub Actions authentication.

5. **Retrieve output values:**
   ```sh
   terraform output
   ```
   Use these values in your GitHub repository settings for authentication.

## GitHub Actions Integration

Once the Workload Identity Pool is created, configure GitHub Actions to authenticate with GCP:
  ```markdown
  name: GCP Workload Identity Federation

  on:
    push:
      branches:
        - main

  jobs:
    authenticate:
      runs-on: ubuntu-latest

      permissions:
        contents: read

      steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Authenticate to GCP
        uses: google-github-actions/auth@v2
        with:
          workload_identity_provider: 'projects/YOUR_PROJECT_ID/locations/global/workloadIdentityPools/YOUR_POOL_ID/providers/YOUR_PROVIDER_ID'
          service_account: 'YOUR_SERVICE_ACCOUNT_EMAIL'

      - name: Run gcloud command
        run: |
          gcloud info

  ```

## Cleanup

To remove the created resources, run:
```sh
terraform destroy
```

## References
- [GCP Workload Identity Federation](https://cloud.google.com/iam/docs/workload-identity-federation)
- [GitHub Actions Authentication with GCP](https://cloud.google.com/blog/products/identity-security/enabling-keyless-authentication-from-github-actions)

## License

This project is licensed under [Apache License](LICENSE).

## Author

Andy Chuang

