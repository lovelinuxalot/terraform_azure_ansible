resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "subnet" {
  count                = var.subnet_counter
  name                 = "subnet${count.index + 1}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.${count.index + 1}.0/24"]
  # network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_public_ip" "Public-Ip" {
  count               = var.vm_count
  name                = "public-ip-${count.index + 1}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "NIC" {
  count               = var.vm_count
  name                = "ethernet${count.index + 1}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "Ipaddress${count.index + 1}"
    subnet_id                     = azurerm_subnet.subnet[count.index].id
    private_ip_address_allocation = "Static"

    private_ip_address   = "10.0.${count.index + 1}.11"
    public_ip_address_id = azurerm_public_ip.Public-Ip[count.index].id
  }
}
resource "azurerm_network_security_group" "nsg" {
  name                = "Network-Security-Rule"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "RMQ"
    priority                   = 2001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "15672"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "nsg-association" {
  count                     = var.subnet_counter
  subnet_id                 = azurerm_subnet.subnet[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

