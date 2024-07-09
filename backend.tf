terraform {
  backend "azurerm" {
    subscription_id      = "2a09dde0-11d6-4209-970b-abbee9d5cc80"
    resource_group_name  = "quant_prod"
    storage_account_name = "stgtfprod"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}