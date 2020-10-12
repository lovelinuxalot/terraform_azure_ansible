provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.20.0"
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.rgname
  location = var.location
}
