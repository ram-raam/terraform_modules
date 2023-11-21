resource "azurerm_service_plan" "jssi_asp" {
  count               = length(var.service_plan_type)
  name                = join("", [ var.Org_caps, var.pln_caps, var.pcl_caps, var.app_caps, var.service_plan_name, var.service_plan_type[count.index], var.env_caps, var.sq_number])
  resource_group_name = var.asp_rg
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name
}

resource "azurerm_app_service" "fc_appservice_api" {
  count               = length (var.service_app_name_api)
  name                =  join("", [ var.Org_caps, var.apprtypes_caps, var.pcl_caps, var.app_caps, var.service_app_name_api[count.index], var.env_caps, var.sq_number])
  location            = var.location
  resource_group_name = var.asp_rg
  app_service_plan_id = azurerm_service_plan.jssi_asp[0].id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    
  }

  /* connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  } */
}

resource "azurerm_app_service" "fc_appservice_ui" {
  count               = length(var.service_app_name_ui)
  name                =  join("", [ var.Org_caps, var.apprtypes_caps, var.pcl_caps, var.app_caps, var.service_app_name_ui[count.index], var.env_caps, var.sq_number])
  location            = var.location
  resource_group_name = var.asp_rg
  app_service_plan_id = azurerm_service_plan.jssi_asp[1].id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    
  }
  
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet_int_app" {
  count               = length(azurerm_app_service.fc_appservice_api[*].id)
  app_service_id = azurerm_app_service.fc_appservice_api[count.index].id
  subnet_id      = var.subnet_id[1]
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet_int_ui" {
  count          = length(azurerm_app_service.fc_appservice_ui[*].id)
  app_service_id = azurerm_app_service.fc_appservice_ui[count.index].id
  subnet_id      = var.subnet_id[0]
}

