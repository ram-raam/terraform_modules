resource "azurerm_mssql_server" "jssi_sql_server" {
 name                       = join("", [var.Org, var.sqlapptype_caps, var.pcl_low,var.app_low, var.env_low, var.sq_number])
  resource_group_name          = var.sql_server_rg
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_username 
  administrator_login_password = var.sql_password
  minimum_tls_version          = "1.2"  
  public_network_access_enabled = false
  
}


resource "azurerm_sql_database" "jssi_sql_database" {
    count               = length (var.dbtype_caps)
  name                =join("", [var.Org, var.dbapptype_caps, var.pcl_low, var.app_low, var.dbtype_caps[count.index], var.env_low, var.sq_number])
  resource_group_name = var.sql_server_rg
  location            = var.location
  server_name         = azurerm_mssql_server.jssi_sql_server.name

}

