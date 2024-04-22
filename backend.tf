terraform {
  backend "azurerm" {
    subscription_id      = "a12ddeee-f964-4eff-9dc4-fb0fa49bacc2"
    resource_group_name  = "quant-rg-prod"
    storage_account_name = "prodtfstate00121"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}