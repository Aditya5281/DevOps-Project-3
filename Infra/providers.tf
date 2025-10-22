terraform {
    required_providers {
      azurerm = {
        version = "~> 3.80"
      }
    }

    backend "azurerm" {
      key = ""
      storage_account_name = ""
      resource_group_name = ""
    }
}

provider "azurerm" {
    alias = "Dev"
    client_id = var.client_id
    client_secret = var.client_secret
    subscription_id = var.dev_subscription_id
    tenant_id = var.tenant_id
    features {}
}

provider "azurerm" {
    alias = "Prod"
    client_id = var.client_id
    client_secret = var.client_secret
    subscription_id = var.prod_subscription_id
    tenant_id = var.tenant_id
    features {}
}