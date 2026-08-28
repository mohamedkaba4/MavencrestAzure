# Environment-specific foundation:
# prod uses foundation-prod.tfstate
# staging uses foundation-staging.tfstate
data "terraform_remote_state" "foundation" {
  backend = "azurerm"

  config = {
    storage_account_name = "stmavencresttfi1zm39"
    container_name       = "tfstate"
    key                  = "foundation-${var.environment}.tfstate"

    use_cli          = true
    use_azuread_auth = true
  }
}

data "terraform_remote_state" "shared" {
  backend = "azurerm"

  config = {
    storage_account_name = "stmavencresttfi1zm39"
    container_name       = "tfstate"
    key                  = "foundation-prod.tfstate"

    use_cli          = true
    use_azuread_auth = true
  }
}
