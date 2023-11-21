resource "azurerm_monitor_diagnostic_setting" "jssi-main" {
    count = length(var.target_resource_id)
    name                              = "diag_setting_for_${var.dia_name}"
    target_resource_id                = var.target_resource_id[count.index]
    log_analytics_workspace_id        = var.log_analytics_workspace_id
    metric {
        category = "AllMetrics"
        retention_policy {
            enabled = false
        }
    }
}