output "service_plan_id" {
  value = azurerm_service_plan.jssi_asp[0].id
}

output "service_plan_id_UI" {
  value = azurerm_service_plan.jssi_asp[1].id
}

output "api_appservice_id" {
  value = azurerm_app_service.fc_appservice_api[*].id
}

output "ui_appservice_id" {
  value = azurerm_app_service.fc_appservice_ui[*].id
}

output "api_appservice_name" {
  value = azurerm_app_service.fc_appservice_api[*].name
}

output "ui_appservice_name" {
  value = azurerm_app_service.fc_appservice_ui[*].name
}