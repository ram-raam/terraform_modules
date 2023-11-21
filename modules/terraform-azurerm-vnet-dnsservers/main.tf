resource "azurerm_virtual_network_dns_servers" "jssi" {
  virtual_network_id = var.vnet_id
  dns_servers        = var.dns_server_ip
}