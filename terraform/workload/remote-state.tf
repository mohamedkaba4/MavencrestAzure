# Environment-specific foundation:
# prod uses foundation-prod.tfstate
# staging uses foundation-staging.tfstate
data "terraform_remote_state" "foundation" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-mavencrest-tfstate"
    storage_account_name = "stmavencresttfi1zm39"
    container_name       = "tfstate"
    key                  = "foundation-${var.environment}.tfstate"
  }
}

# Shared platform resources currently owned by prod foundation:
# ACR + Container Apps Environment
data "terraform_remote_state" "shared" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-mavencrest-tfstate"
    storage_account_name = "stmavencresttfi1zm39"
    container_name       = "tfstate"
    key                  = "foundation-prod.tfstate"
  }
}
