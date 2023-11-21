resource "azurerm_application_insights" "jssi-appinsights" {
  name               = join("", [var.Org, var.appinapptype_caps, var.pcl_low,var.app_low, var.env_low, var.sq_number])
  location            = var.location
  resource_group_name = var.appinsights_rg
  application_type    = var.application_type
}