terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0, < 4.0.0"
    }
  }

  backend "azurerm" {
    key = "terraformdeploy.tfstate"
    storage_account_name = "__StorageAccountName__"
    resource_group_name = "__StorageAccountRG__"
    container_name = "__StorageAccountContainerName__"
  }
}

provider "azurerm" {
  features {}
  // alias = "dev"
  client_id = var.client_id
  client_secret = var.client_secret
  subscription_id = var.dev_subscription_id
  tenant_id = var.tenant_id
}

// provider "azurerm" {
//   // alias = "Prod"
//   client_id = var.client_id
//   client_secret = var.client_secret
//   subscription_id = var.prod_subscription_id
//   tenant_id = var.tenant_id
//   features {}
// }
