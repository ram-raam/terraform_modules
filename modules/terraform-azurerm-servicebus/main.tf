resource "azurerm_servicebus_namespace" "main" {
  name                = join("-", ["sbns", var.Org, var.AZRegion, var.LZType, var.Env, var.sbus_name])
  location            = var.location
  resource_group_name = var.servicebus_rg
  sku                 = var.servicebus_sku_tier
  capacity            = var.servicebus_capacity
  public_network_access_enabled  = false
  tags = var.Tags
}

/*resource "azurerm_servicebus_topic" "jssi_topic" {
  name         = join("-", ["servicbus-topic", var.Org, var.AZRegion, var.LZType, var.Env])
  namespace_id = azurerm_servicebus_namespace.main.id
}

resource "azurerm_servicebus_topic_authorization_rule" "jssi_serbuc_policy" {
  name     = join("-", ["servicbus-auth-policy", var.Org, var.AZRegion, var.LZType, var.Env])
  topic_id = azurerm_servicebus_topic.jssi_topic.id
  listen   = true
  send     = false
  manage   = false
}*/