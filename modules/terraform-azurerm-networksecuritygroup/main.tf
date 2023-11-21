
###################################
# network security group creation #
###################################
resource "azurerm_network_security_group" "network_security_group" {
  name                            = "nsg-snet-${var.Org}-${var.AZRegion}-${var.LZType}-${var.Env}-${var.nsg_end_name}"
  location                        = var.location
  resource_group_name             = var.nsg_group_rg
  tags                            = var.Tags
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                       = var.nsg_subnet_id
  network_security_group_id       = azurerm_network_security_group.network_security_group.id
}
