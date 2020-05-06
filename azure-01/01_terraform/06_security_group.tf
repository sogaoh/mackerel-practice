resource "azurerm_network_security_group" "azure01_nsg" {
  name                = "azure01_nsg"
  resource_group_name = azurerm_resource_group.azure01.name
  location            = azurerm_resource_group.azure01.location
}

resource "azurerm_network_security_rule" "azure01_https-nsg" {
  name                        = "azure01_https-nsg"
  resource_group_name         = azurerm_resource_group.azure01.name
  network_security_group_name = azurerm_network_security_group.azure01_nsg.name
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "443"
  protocol                    = "Tcp"
}

resource "azurerm_network_security_rule" "azure01_http-nsg" {
  name                        = "azure01_http-nsg"
  resource_group_name         = azurerm_resource_group.azure01.name
  network_security_group_name = azurerm_network_security_group.azure01_nsg.name
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  source_address_prefixes     = ["${var.myhome_gip}/32"]
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_ranges     = ["80","3051"]
  protocol                    = "Tcp"
}

resource "azurerm_network_security_rule" "azure01_ssh-external-nsg" {
  name                        = "azure01_ssh-external-nsg"
  resource_group_name         = azurerm_resource_group.azure01.name
  network_security_group_name = azurerm_network_security_group.azure01_nsg.name
  priority                    = 111
  direction                   = "Inbound"
  access                      = "Allow"
  source_address_prefixes     = ["${var.myhome_gip}/32"]
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "22"
  protocol                    = "Tcp"
}

resource "azurerm_network_security_rule" "azure01_ssh-internal-nsg" {
  name                        = "azure01_ssh-internal-nsg"
  resource_group_name         = azurerm_resource_group.azure01.name
  network_security_group_name = azurerm_network_security_group.azure01_nsg.name
  priority                    = 121
  direction                   = "Inbound"
  access                      = "Allow"
  source_address_prefix       = "172.31.0.0/16"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "22"
  protocol                    = "Tcp"
}

resource "azurerm_network_security_rule" "azure01_icmp-internal-nsg" {
  name                        = "azure01_icmp-internal-nsg"
  resource_group_name         = azurerm_resource_group.azure01.name
  network_security_group_name = azurerm_network_security_group.azure01_nsg.name
  priority                    = 122
  direction                   = "Inbound"
  access                      = "Allow"
  source_address_prefix       = "172.31.0.0/16"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "*"
  protocol                    = "Icmp"
}
