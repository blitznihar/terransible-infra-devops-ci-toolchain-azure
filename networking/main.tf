resource "azurerm_resource_group" "resource_group_devops" {
  name     = "DevOpsGroup"
  location = "Central US"

  tags {
    Name  = "DevOpsRG"
    Group = "DevOps"
  }
}

resource "azurerm_network_security_group" "network_security_group_devops" {
  name                = "DevOpsSG"
  location            = "${azurerm_resource_group.resource_group_devops.location}"
  resource_group_name = "${azurerm_resource_group.resource_group_devops.name}"

  security_rule {
    name                       = "ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "http"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "https"
    priority                   = 111
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "webports"
    priority                   = 112
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8000-9200"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_ddos_protection_plan" "ddos_protection_plan_devops" {
  name                = "DevOpsddospplan"
  location            = "${azurerm_resource_group.resource_group_devops.location}"
  resource_group_name = "${azurerm_resource_group.resource_group_devops.name}"
}

resource "azurerm_virtual_network" "virtual_network_devops" {
  name                = "DevOpsVN"
  location            = "${azurerm_resource_group.resource_group_devops.location}"
  resource_group_name = "${azurerm_resource_group.resource_group_devops.name}"
  address_space       = ["10.0.0.0/16"]

  tags {
    Group = "DevOps"
  }
}

resource "azurerm_subnet" "subnet_A_devops" {
  name                 = "subnet_A_devops"
  address_prefix       = "10.0.1.0/24"
  resource_group_name  = "${azurerm_resource_group.resource_group_devops.name}"
  virtual_network_name = "${azurerm_virtual_network.virtual_network_devops.name}"
}

resource "azurerm_subnet" "subnet_B_devops" {
  name                 = "subnet_B_devops"
  address_prefix       = "10.0.2.0/24"
  resource_group_name  = "${azurerm_resource_group.resource_group_devops.name}"
  virtual_network_name = "${azurerm_virtual_network.virtual_network_devops.name}"
}

resource "azurerm_subnet" "subnet_C_devops" {
  name                 = "subnet_C_devops"
  address_prefix       = "10.0.3.0/24"
  resource_group_name  = "${azurerm_resource_group.resource_group_devops.name}"
  virtual_network_name = "${azurerm_virtual_network.virtual_network_devops.name}"
}
