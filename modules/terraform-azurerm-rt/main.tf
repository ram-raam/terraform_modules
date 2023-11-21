resource "azurerm_route_table" "routetable" {
  count                           = length (var.rt_last_names)
  name                            = join("-", [ var.Org_caps, var.peo_caps, var.rtrtypes_caps, var.sub_name_caps, var.pcl_caps, var.app_caps, var.rt_last_names[count.index], var.AZRegion_caps ])
  location                        = var.location
  resource_group_name             = var.routtable_rg
  disable_bgp_route_propagation   = false
  dynamic "route" {
     for_each                      = var.azure_route_table
    content {
      name                        = route.value["name"]
      address_prefix              = route.value["address_prefix"]
      next_hop_type               = route.value["next_hop_type"]
      next_hop_in_ip_address      = route.value["next_hop_in_ip_address"]
      
    }
  }
  tags                            = var.Tags
}


resource "azurerm_subnet_route_table_association" "jssi-rt-ass_app" {
  subnet_id                       = var.subnet_id[3]
  route_table_id                  = azurerm_route_table.routetable[1].id
} 

resource "azurerm_subnet_route_table_association" "jssi-rt-ass_app_db" {
  subnet_id                       = var.subnet_id[2]
  route_table_id                  = azurerm_route_table.routetable[0].id
}

