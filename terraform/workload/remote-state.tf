# Environment-specific foundation state
data "terraform_remote_state" "foundation" {
  backend = "azurerm"

  config = {
    storage_account_name = var.tfstate_storage_account_name
    container_name       = var.tfstate_container_name
    key                  = "foundation-${var.environment}.tfstate"

    use_cli          = true
    use_azuread_auth = true
  }
}

# Shared platform resources currently owned by prod foundation
data "terraform_remote_state" "shared" {
  backend = "azurerm"

  config = {
    storage_account_name = var.tfstate_storage_account_name
    container_name       = var.tfstate_container_name
    key                  = "foundation-prod.tfstate"

    use_cli          = true
    use_azuread_auth = true
  }
}