resource "azurerm_windows_web_app" "jssi_webapp" {
  name                = join("-", ["web", var.Org, var.AZRegion, var.LZType, var.Env, var.webapp_name])
  resource_group_name = var.asp_rg
  location            = var.location
  service_plan_id     = var.service_plan_id
  virtual_network_subnet_id =  var.virtual_network_subnet_id
  https_only              = true
  enabled                 = true
  client_affinity_enabled = true
  
  site_config {
  #public_network_access_enabled  = false
  #public_network_access = "disabled"
  always_on                 = false
    #default_documents        = ""
    #dotnet_framework_version  = "v4.0"
    #http2_enabled            = ""
    #ip_restriction           = ""
    #java_version             = ""
    #java_container           = ""
    #java_container_version   = ""
    #managed_pipeline_mode     = "Integrated"
    #min_tls_version           = "1.2"
    #php_version              = ""
    #python_version           = ""
    #remote_debugging_enabled  = false
    #remote_debugging_version = ""
    #scm_type                  = "None"
    #use_32_bit_worker_process = false
    websockets_enabled        = true
    #ftps_state               = ""

    ip_restriction {
    action = "Allow"
    ip_address = "10.130.32.0/24"
    name = "disable public network access"
  }
 }
}