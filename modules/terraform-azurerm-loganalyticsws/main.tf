resource "azurerm_log_analytics_workspace" "log-analytics-workspace" {
  name                = "log-${var.Org}-${var.AZRegion}-${var.LZType}-${var.Env}-${var.workspace_name}"
  location            = var.location
  resource_group_name = var.workspace_rg
  sku                 = "PerGB2018"
  retention_in_days   = 90
  tags                            = var.Tags
}

resource "azurerm_log_analytics_solution" "la-opf-solution-sentinel" {
  solution_name         = "SecurityInsights"
  location              = var.location
  resource_group_name   = var.workspace_rg
  workspace_resource_id = azurerm_log_analytics_workspace.log-analytics-workspace.id
  workspace_name        = azurerm_log_analytics_workspace.log-analytics-workspace.name
  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }
  tags                            = var.Tags
}
