terraform {
  required_providers {
    azurerm = {
      version = ">=2.46.0"
    }
  }
}
provider "azurerm" {
  features {}
}
