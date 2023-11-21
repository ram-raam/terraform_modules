resource "azurerm_eventhub_namespace" "jssi-ns" {
  name                = "evhub-${var.Org}-${var.AZRegion}-${var.LZType}-${var.Env}-ns-01"
  location            = var.location
  resource_group_name = var.eventhub_azurerm_resource_group
  sku                 = var.eventhub_sku
  capacity            = var.eventhub_capacity
  public_network_access_enabled = false
  tags = var.Tags
}

resource "azurerm_eventhub" "jssi_eventhub" {
  name                = "evhub-${var.Org}-${var.AZRegion}-${var.LZType}-${var.Env}"
  namespace_name      = azurerm_eventhub_namespace.jssi-ns.name
  resource_group_name = var.eventhub_azurerm_resource_group
  partition_count     = var.eventhub_partition_count
  message_retention   = var.eventhub_message_retention
  public_network_access_enabled = fasle
}