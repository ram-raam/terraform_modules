output "resource_group_name" {
    value = [ for rg_name in azurerm_resource_group.jssi-rg : rg_name.name ]
}
output "resource_groupname_id" {
    value = [ for rg_name in azurerm_resource_group.jssi-rg : rg_name.id ]
}
