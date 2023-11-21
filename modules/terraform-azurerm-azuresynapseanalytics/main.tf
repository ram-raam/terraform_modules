data "azurerm_client_config" "current" {}

data "azurerm_subscription" "primary" {}


/* resource "azurerm_role_assignment" "service_principle" {
  scope                  = data.azurerm_subscription.primary.id
  role_definition_name   = "Storage Blob Data Contributor"
  principal_id           = data.azurerm_client_config.current.object_id

} */

resource "azurerm_storage_account" "jssi-syna-storage" {
  name                     = "adminstoragejssi01"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
  public_network_access_enabled = false
  allow_nested_items_to_be_public = false
  #depends_on               = [azurerm_role_assignment.service_principle]
}

/*
resource "azurerm_private_endpoint" "main" {
 name  = "${var.pe_res_name}-${var.Org}-${var.AZRegion}-${var.LZType}-${var.Env}-${var.res_end_name}-pep-01"
 resource_group_name =  var.resource_group_name
 location  = var.location
 subnet_id = var.subnet_id
 private_dns_zone_group {
  name = "default"
  private_dns_zone_ids = var.storage_private_dns_zone_id
 }
private_service_connection {
  is_manual_connection  = false
  private_connection_resource_id = azurerm_storage_account.jssi-syna-storage.id
  name   = "pe-${var.Org}-${var.AZRegion}-${var.LZType}-${var.Env}-psc"
  subresource_names = var.sub_resource_list_storage"
}
*/

/* resource "azurerm_private_endpoint" "main" {
 name       = "${var.pe_res_name}-${var.Org}-${var.AZRegion}-${var.LZType}-${var.Env}-${var.res_end_name}-pep-01"
 resource_group_name = var.private_endpoint_rg
 location   = var.location
 subnet_id = var.private_subnet_id
  private_dns_zone_group {
    name  = "default"
    private_dns_zone_ids = var.private_dns_zone_id
  }
  private_service_connection {
    is_manual_connection  = false
    private_connection_resource_id = azurerm_storage_account.jssi-syna-storage.id
    name  = "pe-${var.Org}-${var.AZRegion}-${var.LZType}-${var.Env}-psc"
    subresource_names = var.sub_resource_list
  } */

#}


/* resource "azurerm_private_endpoint" "main_dfs" {
 name       = "${var.pe_res_name}-${var.Org}-${var.AZRegion}-${var.LZType}-${var.Env}-${var.res_end_name}-pepdfs-01"
 resource_group_name = var.private_endpoint_rg
 location   = var.location
 subnet_id = var.private_subnet_id
  private_dns_zone_group {
    name  = "default"
    private_dns_zone_ids = var.private_dns_zone_id_dfs
  }
  private_service_connection {
    is_manual_connection  = false
    private_connection_resource_id = azurerm_storage_account.jssi-syna-storage.id
    name  = "pedfs-${var.Org}-${var.AZRegion}-${var.LZType}-${var.Env}-psc"
    subresource_names = ["dfs"]
  }

} */


resource "azurerm_storage_data_lake_gen2_filesystem" "jssi-main" {
  depends_on         = [azurerm_storage_account.jssi-syna-storage]
  name               = "datalake-${var.Org}-${var.AZRegion}-${var.LZType}-${var.Env}"
  storage_account_id = azurerm_storage_account.jssi-syna-storage.id
  
}

resource "azurerm_synapse_workspace" "jssi-main" {
  depends_on         = [azurerm_storage_account.jssi-syna-storage, azurerm_storage_data_lake_gen2_filesystem.jssi-main]
  name                                 = "synws-${var.Org}-${var.AZRegion}-${var.LZType}-${var.Env}-apps-01"
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.jssi-main.id
  #storage_data_lake_gen2_filesystem_id = azurerm_storage_container.jssi-cn.id
  #storage_data_lake_gen2_filesystem_id = null_resource.jssi_datalakefs.id
  sql_administrator_login              = var.sql_administrator_login_synapse
  sql_administrator_login_password     = var.sql_administrator_login_password_synapse
  managed_virtual_network_enabled      = true
  public_network_access_enabled        = false

  aad_admin {
    login     = "AzureAD Admin"
    object_id = data.azurerm_client_config.current.object_id
    tenant_id = data.azurerm_client_config.current.tenant_id
  }

  identity {
    type = "SystemAssigned"
    #type          = "UserAssigned"
  }

  tags = var.Tags
}



/*
locals {
  name                = join("-", ["datalake", var.Org, var.AZRegion, var.LZType, var.Env,])
}

resource "null_resource" "jssi_datalakefs" {
  provisioner "local-exec" {
    command = "az storage fs create -n ${local.name} --account-name ${var.storage_account_name_synap} --auth-mode login"
    interpreter = ["PowerShell", "-Command"]
  }
}
*/

/*resource "azurerm_role_assignment" "syn_st_role_admin_sbdc" {
  scope                = var.storage_account_id_synapse
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}
*/

