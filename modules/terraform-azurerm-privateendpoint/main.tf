resource "azurerm_private_endpoint" "main" {
    #count               = length (var.res_conn_id)
    name                = "${var.resource_name}"  
    resource_group_name = var.private_endpoint_rg
    location            = var.location
    subnet_id           = var.private_subnet_id
    private_service_connection {
        is_manual_connection           = false
        private_connection_resource_id = var.res_conn_id
        name                           = "PVTENDPOINT-${var.Org_caps}-${var.app_caps}-${var.pcl_caps}-${var.env_caps}-PSC"
        subresource_names =  var.sub_resource_list
    }
}


