output "private_endpoint_id" {
  value = azurerm_private_endpoint.main[*].id
}