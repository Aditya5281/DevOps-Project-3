data "azurerm_resource_group" "prod_rg" {
  name = "RGP-USE-IACT1-DEV"
}

data "azurerm_resource_group" "dev_rg" {
  name = "RGP-USE-IACT1-DEV"
}

data "azurerm_user_assigned_identity" "mi" {
  name = "mi-use-iact1-dev"
  resource_group_name = "RGP-USE-IACT1-DEV"
}
