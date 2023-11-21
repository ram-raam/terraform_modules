resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link-0" {
  count                         = length(var.private-dns-zone-name)
  name                          = "vnetlink-for-${var.env_name}"
  resource_group_name           = var.private_dns_rg
  private_dns_zone_name         = var.private-dns-zone-name[count.index]
  virtual_network_id            = var.vnet_id
  registration_enabled          = false
}