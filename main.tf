terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
    }
  }
}

data "azurerm_client_config" "current" {}

provider "azuread" {
  tenant_id = data.azurerm_client_config.current.tenant_id
}

provider "azurerm" {
  features {}
}

module "conditional_access" {
  source   = "github.com/RonNavonCE/poalim-modules-tf//conditional_access"
  policies = var.policies
}
