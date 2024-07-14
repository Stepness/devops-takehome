output "db_public_ip" {
  value = azurerm_public_ip.this["db"].ip_address
}

output "webserver_public_ip" {
  value = azurerm_public_ip.this["webserver"].ip_address
}
