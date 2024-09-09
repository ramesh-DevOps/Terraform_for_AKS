terraform {
  required_providers {
    azurerm = {
      version = ">=2.46.0"
    }
  }
}
provider "azurerm" {
  features {}

  # Specify the subscription ID
  subscription_id = $(ARM_SUBSCRIPTION_ID)
}
