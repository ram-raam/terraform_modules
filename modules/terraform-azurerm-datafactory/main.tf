resource "azurerm_data_factory" "jssi_data" {
  name                = "adf-${var.Org}-${var.AZRegion}-${var.LZType}-${var.Env}-apps-01"
  location            = var.location
  resource_group_name = var.resource_group_name_df
  public_network_enabled = false
}