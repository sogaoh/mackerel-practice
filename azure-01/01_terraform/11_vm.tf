# refs https://github.com/terraform-providers/terraform-provider-azurerm/blob/master/examples/virtual-machines/linux/public-ip/main.tf

resource "azurerm_public_ip" "sandbox-01_pip" {
  name                = "sandbox-01_pip"
  resource_group_name = azurerm_resource_group.azure01.name
  location            = azurerm_resource_group.azure01.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "sandbox-01_nic" {
  name                = "sandbox-01_nic"
  location            = azurerm_resource_group.azure01.location
  resource_group_name = azurerm_resource_group.azure01.name

  ip_configuration {
    name                          = "sandbox-01_ip-config"
    subnet_id                     = azurerm_subnet.azure01_sandbox-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.sandbox-01_pip.id
  }
}

resource "azurerm_network_interface_security_group_association" "sandbox-01_sg-assoc" {
  network_interface_id      = azurerm_network_interface.sandbox-01_nic.id
  network_security_group_id = azurerm_network_security_group.azure01_nsg.id
}

resource "azurerm_linux_virtual_machine" "sandbox-01" {
  name                = "sandbox-01"
  resource_group_name = azurerm_resource_group.azure01.name
  location            = azurerm_resource_group.azure01.location
  size                = "Standard_D2_v3"
  admin_username      = var.vm_admin_user
  network_interface_ids = [
    azurerm_network_interface.sandbox-01_nic.id,
  ]

  admin_ssh_key {
    username   = var.vm_admin_user
    public_key = var.vm_admin_ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = "32"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
