resource "azurerm_network_security_group" "nsgr-mgm-group" {
  name                = "nsg-${azurerm_subnet.prd-management-01.name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.RG-MANAGEMENT-SECURITY.name
  tags                            = var.Tags
}
resource "azurerm_subnet_network_security_group_association" "appgateway_nsg_association" {
  subnet_id                 = azurerm_subnet.prd-management-01.id
  network_security_group_id = azurerm_network_security_group.nsgr-mgm-group.id
}
