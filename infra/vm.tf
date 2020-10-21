// Create a virtual network and subnet for the VM
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-js-wksp"
  address_space       = ["10.200.200.0/24"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "snet" {
  name                 = "snet-js-wksp"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.200.200.0/24"]
}

// Create a public IP for the VM
resource "azurerm_public_ip" "pip" {
  count               = var.server_count
  name                = "pip-js-wksp-${count.index}"
  location            = "uksouth"
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

// Create the  VM NIC and associate with the Public IP
resource "azurerm_network_interface" "nic" {
  count               = var.server_count
  name                = "nic-js-wksp-${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "default"
    subnet_id                     = azurerm_subnet.snet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[count.index].id
  }
}

// Setup an NSG and associate with the NIC - this will allow SSH traffic
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-js-wksp"
  location            = "uksouth"
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = chomp(data.http.icanhazip.body)
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Web"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = chomp(data.http.icanhazip.body)
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "nsga" {
  count                     = var.server_count
  network_interface_id      = azurerm_network_interface.nic[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_linux_virtual_machine" "vm" {
  count                 = var.server_count
  name                  = "vm-js-wksp-${count.index}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  size                  = "Standard_B1s"

  computer_name                   = "vm-${count.index}"
  admin_username                  = "azure_admin"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azure_admin"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    name                 = "disk-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  identity {
    type = "SystemAssigned"
  }
}





