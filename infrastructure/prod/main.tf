/*
Terraform automatically loads every .tf file in this directory.

Project structure:
- versions.tf                  Terraform & provider versions
- providers.tf                 Azure provider configuration
- variables.tf                 Input variables
- locals.tf                    Shared names and tags
- naming.tf                    Random naming resources
- resource-group.tf            Azure Resource Group
- monitoring.tf                Log Analytics Workspace
- container-registry.tf        Azure Container Registry (ACR)
- container-app-environment.tf Azure Container Apps Environment
- container-app.tf             Storefront Container App
- outputs.tf                   Deployment outputs
*/
