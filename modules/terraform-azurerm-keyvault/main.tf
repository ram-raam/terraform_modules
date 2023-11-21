data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "jssi-kv" {
  name                         = join("", [var.Org, var.kvapptype_caps, var.pcl_low,var.app_low, var.env_low, var.sq_number])
  location                     = var.location
  resource_group_name          = var.keyvault_rg
  enabled_for_disk_encryption  = true
  enable_rbac_authorization    = false
  soft_delete_retention_days   = 7
  purge_protection_enabled     = true
  tenant_id                    = data.azurerm_client_config.current.tenant_id
  sku_name                     = "standard"
  public_network_access_enabled = false
  network_acls {
    default_action             = "Allow"
    bypass                     = "AzureServices"
    virtual_network_subnet_ids = var.subnet_ids
  }
}