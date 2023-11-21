output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}
output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "subnets" {
    value = { for subnet in azurerm_subnet.subnets : subnet.name => subnet.id }
}

output "subnets_id" {
    value = [ for subnet in azurerm_subnet.subnets : subnet.id ]
}