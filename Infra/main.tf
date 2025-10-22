# Dev Web App
resource "azurerm_app_service_plan" "dev_plan" {
    provider            = azurerm.Dev
    name                = var.asp_dev
    location            = data.azurerm_resource_group.dev_rg.location
    resource_group_name = data.azurerm_resource_group.dev_rg.name
    kind                = "Linux"
    reserved            = true

    sku {
        tier = "Basic"
        size = "B1"
    }
}

# Prod Web App
resource "azurerm_app_service_plan" "prod_plan" {
    provider            = azurerm.Prod
    name                = var.asp_prod
    location            = data.azurerm_resource_group.prod_rg.location
    resource_group_name = data.azurerm_resource_group.prod_rg.name
    kind                = "Linux"
    reserved            = true

    sku {
        tier = "Standard"
        size = "S1"
    }
}

# Dev Web App
resource "azurerm_linux_web_app" "webapp" {
    provider = azurerm.Dev
    name                = var.webapp
    location            = data.azurerm_resource_group.rg.location
    resource_group_name = data.azurerm_resource_group.rg.name
    service_plan_id     = azurerm_app_service_plan.dev_plan.id

    site_config {
        linux_fx_version = "PYTHON:3.11"
    }

    app_settings = {
        "WEBSITES_PORT" = "5000"
    }
}

# Azure Container Registry
resource "azurerm_container_registry" "acr" {
    provider = azurerm.Dev
    name = var.acr_name
    resource_group_name = data.azurerm_resource_group.dev_rg.name
    location = data.azurerm_resource_group.dev_rg.location
    sku = "Basic"
    admin_enabled = true
}

# Azure Kubernetes Service
resource "azurerm_kubernetes_cluster" "dev_aks" {
  provider            = azurerm.Dev
  name                = var.aks_name
  location            = data.azurerm_resource_group.dev_rg.location
  resource_group_name = data.azurerm_resource_group.dev_rg.name
  dns_prefix          = "devaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  depends_on = [azurerm_container_registry.dev_acr]
}

resource "azurerm_role_assignment" "aks_role" {
    provider = azurerm.Dev
    scope = azurerm_container_registry.acr.id
    role_definition_name = "AcrPull"
    principal_id = azurerm_kubernetes_cluster.dev_aks.identity[0].principal_id
}