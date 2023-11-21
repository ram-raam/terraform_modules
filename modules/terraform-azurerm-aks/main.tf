resource "azurerm_kubernetes_cluster" "jssi-aks" {
  name                = join("", ["aks", var.Org, var.AZRegion, var.LZType_cr])
  location            = var.location
  resource_group_name = var.Aks_rg
  dns_prefix          = "exampleaks1"
  private_cluster_enabled = true

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}