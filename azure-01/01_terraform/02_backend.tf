terraform {
  backend "azurerm" {
    resource_group_name   = "tf-state"
    storage_account_name  = "tfuser"
    container_name        = "tfstate"
    key                   = "azure01.tfstate"
  }
}