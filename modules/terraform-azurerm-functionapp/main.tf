
resource "azurerm_function_app" "fc_functionapp" {
  name                       = join("", ["fn", var.Org, var.AZRegion, var.LZType, var.Env, var.functionapp_name])
  location                   = var.location
  resource_group_name        = var.asp_rg
  app_service_plan_id        = var.app_service_plan_id 
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
}