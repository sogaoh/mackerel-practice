resource "azurerm_virtual_network" "azure01_vnet" {
  name                = "azure01_vnet"
  resource_group_name = azurerm_resource_group.azure01.name
  location            = azurerm_resource_group.azure01.location
  address_space       = ["172.31.0.0/16"]
}

resource "azurerm_subnet" "azure01_sandbox-subnet" {
  name                 = "azure01_sandbox-subnet"
  virtual_network_name = azurerm_virtual_network.azure01_vnet.name
  resource_group_name  = azurerm_resource_group.azure01.name
  address_prefixes     = ["172.31.28.0/23"]
}
