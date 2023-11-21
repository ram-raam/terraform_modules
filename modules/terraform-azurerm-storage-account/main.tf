resource "azurerm_storage_account" "storage_account" {
  name                      = join("", [ var.Org, var.stapptype_caps, var.pcl_low,var.app_low, var.env_low, var.sq_number])
  resource_group_name       = var.storage_rg
  location                  = var.location
  account_tier              = var.storage_account_tier
  account_replication_type  = var.storage_account_replication_type
  enable_https_traffic_only = true
  is_hns_enabled            = var.enable_data_lake_filesystem
  account_kind              = var.account_kind
  public_network_access_enabled = false
  network_rules {
    default_action             = "Allow"
    bypass                     = var.bypass_internal_network_rules ? ["Logging", "Metrics", "AzureServices"] : ["None"]
    virtual_network_subnet_ids = var.permitted_virtual_network_subnet_ids
  }
  identity {
    type = "SystemAssigned"
  }
}