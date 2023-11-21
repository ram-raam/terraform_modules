resource "azurerm_public_ip" "gateway-ip" {
  name                                = "vpngw-${var.Org}-${var.AZRegion}-${var.LZType}-${var.Env}-shared-01-pip-01"
  location                            = var.location
  resource_group_name                 = var.vnetgateway_rg
  allocation_method                   = var.vnet_pip_alloc_method
  sku                                 = var.vnet_pip_sku
  zones                               = var.vnet_pip_zones
  tags                                = var.Tags
}

resource "azurerm_virtual_network_gateway" "vnetgateway" {
    name                              = "vpngw-${var.Org}-${var.AZRegion}-${var.LZType}-${var.Env}-shared-01"
    location                          = var.location
    resource_group_name               = var.vnetgateway_rg
    type                              = var.vnet_type
    vpn_type                          = var.vnet_vpn_type
    generation                        = var.vnet_generation
    active_active                     = var.vnet_active_active
    enable_bgp                        = var.vnet_enable_bgp
    sku                               = var.vnet_sku
    ip_configuration {
        name                          = "vpngw-pip-config"
        public_ip_address_id          = azurerm_public_ip.gateway-ip.id
        private_ip_address_allocation = "Dynamic"
        subnet_id                     = var.gatewaysnet
    }
     vpn_client_configuration {
      address_space   = var.vpnclient_address_space
      vpn_auth_types  = var.vpn_auth_types
      vpn_client_protocols = var.vpn_client_protocols
      aad_tenant      = "https://login.microsoftonline.com/${var.vnet_tenant}"
      aad_audience    = var.vnet_aad_audiance
      aad_issuer      = "https://sts.windows.net/${var.vnet_tenant}/"
    }
    # custom_route {
    #   address_prefixes = ["0.0.0.0/1","128.0.0.0/1"]
    # }
     tags                              = var.Tags
}
