output "rt_id" {
  value = azurerm_route_table.routetable[*].id
}
output "rt_name" {
  value = azurerm_route_table.routetable[*].name
}