# Mavencrest Azure Platform

Infrastructure-as-Code and CI/CD platform for deploying a containerized version of the Mavencrest Store application to Microsoft Azure, which scales to zero when there is no traffic.

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

Live website link: 
https://store.az.mavencrest.site
https://admin.az.mavencrest.site

## Initial Deployment

The initial deployment requires application container images to exist in Azure Container Registry before Azure Container Apps are provisioned.

The following secrets are required to be defined for both prod and staging env in Key Vault: 
auth-secret          
database-url          
github-client-id      
github-client-secret  
google-client-id      
google-client-secret  
ADMIN_EMAIL
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


This Azure deployment has been stress tested with Grafana's K6 tool to determine how the app scales in high demand scenerioes. The scaling has been passed with 0 interrupted iterations.


Architecture

Orchestration Pipeline
Azure Devops
Terraform is split into foundation and workload
Foundation builds the ACR, Container environment, resource groups and other essential backbone infrastructure.
Azure DevOps tests the code, builds the Docker Image with the Dockerfile, pushed to the staging environment, gets smoke tested, and is subject to a manual approval step. Once approved, deployment is pushed to prod with new container revision. 
Rollback is automated with post deployment smoketest failure, previous revision is set as active.


