resource "azurerm_eventhub_namespace" "jssi-ns" {
  name                = "evhns-${var.Org}-${var.AZRegion}-${var.LZType}-${var.Env}-apps-01"
  location            = var.location
  resource_group_name = var.eventhub_azurerm_resource_group
  sku                 = var.eventhub_sku
  capacity            = var.eventhub_capacity
  public_network_access_enabled  = false
  tags                = var.Tags
  network_rulesets {
    default_action =  "Deny"
    public_network_access_enabled = false
    trusted_service_access_enabled = false
    virtual_network_rule {
    subnet_id                                       = var.vnet_subnet_id
    ignore_missing_virtual_network_service_endpoint = false
    
    }

  }
}

/*resource "azurerm_eventhub" "jssi-ev" {
  name                = "evhub-${var.Org}-${var.AZRegion}-${var.LZType}-${var.Env}"
  namespace_name      = azurerm_eventhub_namespace.jssi-ns.name
  resource_group_name = var.eventhub_azurerm_resource_group
  partition_count     = var.eventhub_partition_count
  message_retention   = var.eventhub_message_retention

}
*/