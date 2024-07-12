resource "azurerm_resource_group" "this" {
  name     = "${var.project}-rg-${var.env}"
  location = var.location
}