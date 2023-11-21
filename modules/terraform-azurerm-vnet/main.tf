# vnet and subnet creation with service endpoints


resource azurerm_virtual_network "vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_rg
  location            = var.location
  address_space       = [var.vnet_address_space]
  tags                = var.Tags
}

resource "azurerm_subnet" "subnets" {
  for_each             = var.subnet
  name                 = contains(["AzureFirewallSubnet", "AzureBastionSubnet", "GatewaySubnet"], each.value["name"]) ? each.value["name"]: join("-", [ var.Org_caps, var.peo_caps, var.snetapps_caps, var.sub_name_caps, var.pcl_caps, var.app_caps, each.value["name"], var.AZRegion_caps])
  resource_group_name  = var.vnet_rg
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value["address_prefixes"]]
  service_endpoints    = var.service_endpoints
  dynamic "delegation" {
    for_each = each.value.enabled_service_delegation == true ? [1]:[]
    content {
      name = "delegation"
      service_delegation {
        name    = each.value.service_delegation_name
        actions = each.value.service_delegation_actions
      }
    }
  }
}