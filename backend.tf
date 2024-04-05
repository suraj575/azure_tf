terraform {
  backend "azurerm" {
    subscription_id      = "1e8fcde0-2f95-41b1-b87a-12bf2da5ada8"
    resource_group_name  = "inizio_adv_dev"
    storage_account_name = "devtfstate00121"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}