resource "azurerm_resource_group" "jssi-rg" {
  count                         = length(var.rgname_caps)
  name                          = var.rgname_caps[count.index]
  location                      = var.location
  tags                          = var.Tags
}