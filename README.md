# Mavencrest Azure Platform

Infrastructure-as-Code and CI/CD platform for deploying a containerized version of Mavencrest Store application to Microsoft Azure.

## Components

- Terraform
- Azure Container Registry
- Azure Container Apps
- GitHub Actions
- Docker
- Managed Identity
- Azure Key Vault (future)
- Application Insights (future)

This repository provisions the Azure infrastructure and deploys the containerized Mavencrest Store application.

## Initial Deployment

The initial deployment requires application container images to exist in Azure Container Registry before Azure Container Apps are provisioned.

The following secrets are required to be defined in Key Vault: 
auth-secret          
database-url          
github-client-id      
github-client-secret  
google-client-id      
google-client-secret  

### Bootstrap Order

1. Provision the foundational Azure infrastructure with Terraform:
   - Resource Group
   - Azure Container Registry
   - Container Apps Environment
   - Key Vault

2. Run the application bootstrap pipeline to:
   - Build the Storefront Docker image
   - Build the Admin Docker image
   - Push both images to Azure Container Registry

3. Configure the initial image references in `prod.tfvars`.

4. Run Terraform to provision:
   - Storefront Container App
   - Admin Container App
   - Managed identities
   - RBAC assignments
   - Ingress configuration

5. After initial provisioning, normal Azure Pipelines deployments build and push new image versions and update the Container Apps.

Terraform manages the infrastructure configuration, while Azure Pipelines manages application image versions.
