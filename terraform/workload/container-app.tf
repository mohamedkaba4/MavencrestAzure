resource "azurerm_container_app" "storefront" {
  name                         = "ca-${local.prefix}-storefront"
  container_app_environment_id = data.terraform_remote_state.shared.outputs.container_app_environment_id
  resource_group_name          = data.terraform_remote_state.foundation.outputs.resource_group_name
  revision_mode                = "Single"

  identity {
    type = "SystemAssigned"
  }

  registry {
    server   = data.terraform_remote_state.shared.outputs.container_registry_login_server
    identity = "system"
  }

  secret {
    name                = "database-url"
    identity            = "System"
    key_vault_secret_id = "${data.terraform_remote_state.foundation.outputs.key_vault_uri}secrets/${local.key_vault_secrets.database_url}"
  }

  secret {
    name                = "auth-secret"
    identity            = "System"
    key_vault_secret_id = "${data.terraform_remote_state.foundation.outputs.key_vault_uri}secrets/${local.key_vault_secrets.auth_secret}"
  }

  secret {
    name                = "google-client-id"
    identity            = "System"
    key_vault_secret_id = "${data.terraform_remote_state.foundation.outputs.key_vault_uri}secrets/${local.key_vault_secrets.google_client_id}"
  }

  secret {
    name                = "google-client-secret"
    identity            = "System"
    key_vault_secret_id = "${data.terraform_remote_state.foundation.outputs.key_vault_uri}secrets/${local.key_vault_secrets.google_client_secret}"
  }

  secret {
    name                = "github-store-id"
    identity            = "System"
    key_vault_secret_id = "${data.terraform_remote_state.foundation.outputs.key_vault_uri}secrets/${local.key_vault_secrets.github_store_id}"
  }

  secret {
    name                = "github-store-secret"
    identity            = "System"
    key_vault_secret_id = "${data.terraform_remote_state.foundation.outputs.key_vault_uri}secrets/${local.key_vault_secrets.github_store_secret}"
  }

  template {
    min_replicas = 0
    max_replicas = 10

    container {
      name   = "storefront"
      image  = var.storefront_container_image
      cpu    = 0.5
      memory = "1Gi"

      env {
        name  = "NODE_ENV"
        value = "production"
      }

      env {
        name  = "NEXTAUTH_URL"
        value = "https://store.az.mavencrest.site"
      }

      env {
        name        = "DATABASE_URL"
        secret_name = "database-url"
      }

      env {
        name        = "NEXTAUTH_SECRET"
        secret_name = "auth-secret"
      }

      env {
        name        = "GOOGLE_CLIENT_ID"
        secret_name = "google-client-id"
      }

      env {
        name        = "GOOGLE_CLIENT_SECRET"
        secret_name = "google-client-secret"
      }

      env {
        name        = "GITHUB_ID"
        secret_name = "github-store-id"
      }

      env {
        name        = "GITHUB_SECRET"
        secret_name = "github-store-secret"
      }
    }
  }

  ingress {
    external_enabled = true
    target_port      = 3000

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].container[0].image
    ]
  }

  tags = local.tags
}

resource "azurerm_container_app" "admin" {
  name                         = "ca-${local.prefix}-admin"
  container_app_environment_id = data.terraform_remote_state.shared.outputs.container_app_environment_id
  resource_group_name          = data.terraform_remote_state.foundation.outputs.resource_group_name
  revision_mode                = "Single"

  identity {
    type = "SystemAssigned"
  }

  registry {
    server   = data.terraform_remote_state.shared.outputs.container_registry_login_server
    identity = "system"
  }

  secret {
    name                = "database-url"
    identity            = "System"
    key_vault_secret_id = "${data.terraform_remote_state.foundation.outputs.key_vault_uri}secrets/${local.key_vault_secrets.database_url}"
  }

  secret {
    name                = "auth-secret"
    identity            = "System"
    key_vault_secret_id = "${data.terraform_remote_state.foundation.outputs.key_vault_uri}secrets/${local.key_vault_secrets.auth_secret}"
  }

  secret {
    name                = "google-client-id"
    identity            = "System"
    key_vault_secret_id = "${data.terraform_remote_state.foundation.outputs.key_vault_uri}secrets/${local.key_vault_secrets.google_client_id}"
  }

  secret {
    name                = "google-client-secret"
    identity            = "System"
    key_vault_secret_id = "${data.terraform_remote_state.foundation.outputs.key_vault_uri}secrets/${local.key_vault_secrets.google_client_secret}"
  }

  secret {
    name                = "github-admin-id"
    identity            = "System"
    key_vault_secret_id = "${data.terraform_remote_state.foundation.outputs.key_vault_uri}secrets/${local.key_vault_secrets.github_admin_id}"
  }

  secret {
    name                = "github-admin-secret"
    identity            = "System"
    key_vault_secret_id = "${data.terraform_remote_state.foundation.outputs.key_vault_uri}secrets/${local.key_vault_secrets.github_admin_secret}"
  }

  secret {
    name                = "admin-email"
    identity            = "System"
    key_vault_secret_id = "${data.terraform_remote_state.foundation.outputs.key_vault_uri}secrets/${local.key_vault_secrets.admin_email}"
  }

  template {
    min_replicas = 0
    max_replicas = 10

    container {
      name   = "admin"
      image  = var.admin_container_image
      cpu    = 0.5
      memory = "1Gi"

      env {
        name  = "NODE_ENV"
        value = "production"
      }

      env {
        name        = "DATABASE_URL"
        secret_name = "database-url"
      }

      env {
        name  = "NEXTAUTH_URL"
        value = "https://admin.az.mavencrest.site"
      }

      env {
        name        = "NEXTAUTH_SECRET"
        secret_name = "auth-secret"
      }

      env {
        name        = "GOOGLE_CLIENT_ID"
        secret_name = "google-client-id"
      }

      env {
        name        = "GOOGLE_CLIENT_SECRET"
        secret_name = "google-client-secret"
      }

      env {
        name        = "GITHUB_ID"
        secret_name = "github-admin-id"
      }

      env {
        name        = "GITHUB_SECRET"
        secret_name = "github-admin-secret"
      }

      env {
       name        = "ADMIN_EMAIL"
      secret_name  = "admin-email"
      }
    }
  }

  ingress {
    external_enabled = true
    target_port      = 3001

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].container[0].image
    ]
  }

  tags = local.tags
}

locals {
  key_vault_secrets = {
    database_url         = "database-url"
    auth_secret          = "auth-secret"
    google_client_id     = "google-client-id"
    google_client_secret = "google-client-secret"
    github_store_id     = "github-store-id"
    github_store_secret = "github-store-secret"
    github_admin_id     = "github-admin-id"
    github_admin_secret = "github-admin-secret"
    admin_email          = "admin-email"
  }
}
