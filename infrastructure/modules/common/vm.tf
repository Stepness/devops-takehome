resource "azurerm_linux_virtual_machine" "db" {
  name                = "${var.project}-vm-db-${var.env}"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.db.id
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("../../resources/key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "webserver" {
  name                = "${var.project}-vm-webserver-${var.env}"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.webserver.id
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("../../resources/key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

resource "azurerm_public_ip" "webserver" {
  name                = "${var.project}-pip-webserver-${var.env}"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "webserver" {
  name                = "${var.project}-nic-webserver-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.webserver.id
  }
}

resource "azurerm_network_interface" "db" {
  name                = "${var.project}-nic-db-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
  }
}