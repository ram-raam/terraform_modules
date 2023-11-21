resource "azurerm_logic_app_workflow" "jssi-logicapp" {
  count               = length(var.logicapp_name)
  name                = join("-", ["logic", var.Org, var.AZRegion, var.LZType, var.Env, var.logicapp_name[count.index]])
  location            = var.location
  resource_group_name = var.logicapp_rg
}