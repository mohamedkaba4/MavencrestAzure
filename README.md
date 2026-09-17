# Mavencrest Azure Platform

Infrastructure-as-Code (IaC) and Continuous Integration/Continuous Delivery (CI/CD) platform for deploying the containerized Mavencrest Store application to Microsoft Azure.

Live:

https://store.az.mavencrest.site
https://admin.az.mavencrest.site

## Business Problem

The platform provides a repeatable way to deploy and update the Mavencrest Store without manually configuring Azure resources.

It uses Terraform for infrastructure, Azure DevOps for application deployments, Azure Key Vault for secrets, Managed Identity for secure access, and Azure Container Apps for autoscaling and scale-to-zero.

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


This Azure deployment has been stress-tested with Grafana's K6 tool to determine how the app scales in high-demand scenarios. Scaling passed with 0 interrupted iterations.


Architecture

Orchestration Pipeline
Azure Devops
Terraform is split into foundation and workload
Foundation builds the ACR, Container environment, resource groups, and other essential backbone infrastructure.
Azure DevOps tests the code, builds the Docker Image with the Dockerfile, pushed to the staging environment, gets smoke tested, and is subject to a manual approval step. Once approved, the deployment is pushed to prod with the new container revision. 
Rollback is automated with a post-deployment smoke test. If there is a failure, the previous revision is set as active.

## Key Decisions
Azure Container Apps instead of Virtual Machines or Kubernetes to reduce infrastructure management and support scale-to-zero.
Terraform for repeatable, version-controlled infrastructure.
Azure DevOps for image builds and deployments so application releases are separate from infrastructure changes.
Managed Identity instead of stored Azure credentials.
Azure Key Vault for application secrets.
Revision-based deployments with smoke testing and automated rollback to the previous working revision.
Separate foundation and workload Terraform to reduce infrastructure blast radius.

## What I Would Change at Production Scale
For a larger production environment, I would add:
Azure Front Door and Web Application Firewall (WAF)
Multi-region deployments and failover
Separate Azure subscriptions for staging and production
Private networking and Private Endpoints
Canary or blue/green deployments
More detailed monitoring, alerting, and distributed tracing
Container image and dependency security scanning
Stronger Terraform state isolation and recovery controls

The current design is intentionally optimized for a low-cost portfolio environment while still following production-style deployment and infrastructure practices.

## Components

- Terraform
- Azure Container Registry
- Azure Container Apps
- GitHub Actions
- Docker
- Managed Identity
- Azure Key Vault
- Application Insights
- Azure Monitor


