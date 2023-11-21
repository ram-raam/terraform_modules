resource "azurerm_mssql_managed_instance" "jssi_sql_mi" {
  name                         = join("-", ["sqlmi", var.Org, var.AZRegion, var.LZType, var.Env, var.sql_name])
  resource_group_name          = var.resource_group_name_sql
  location                     = var.location
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  license_type                 = var.license_type
  subnet_id                    = var.subnet_id_sql
  sku_name                     = var.sku_name
  vcores                       = var.vcores
  storage_size_in_gb           = var.storage_size_in_gb_synapse
}

