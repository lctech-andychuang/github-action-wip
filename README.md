# Terraform Project

This repository contains Terraform configurations for deploying infrastructure.

## Files Structure

```
.
├── main.tf       # Defines the main infrastructure resources
├── output.tf     # Specifies output variables
├── providers.tf  # Configures provider settings
└── variables.tf  # Defines input variables
```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- Appropriate cloud provider credentials configured

## Usage

1. Initialize the Terraform project:
   ```sh
   terraform init
   ```

2. Preview the execution plan:
   ```sh
   terraform plan
   ```

3. Apply the configuration to create infrastructure:
   ```sh
   terraform apply 
   ```

4. Destroy the infrastructure if needed:
   ```sh
   terraform destroy
   ```

## Outputs

Refer to `output.tf` for defined outputs that provide useful information about the deployed resources.

## Variables

The `variables.tf` file defines configurable parameters. You can customize them using a `terraform.tfvars` file or command-line options.

## License

This project is licensed under [MIT License](LICENSE).

## Author

Andy Chuang

