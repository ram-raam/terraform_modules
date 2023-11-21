resource "azurerm_network_interface" "fc_nic" {
  name                = "fcvm-nic"
  location            = var.location
  resource_group_name = var.asp_rg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "fc_vm" {
  name                = join("", [ var.Org_caps, var.vm_caps, var.pcl_caps, var.app_caps, var.env_caps])
  resource_group_name = var.asp_rg
  location            = var.location
  size                = var.vm_size
  admin_username      = var.vm_username
  admin_password      = var.vm_password
  network_interface_ids = [
    azurerm_network_interface.fc_nic.id,
  ]

   os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}


resource "azurerm_managed_disk" "fc_mgdisk" {
  name                 = "fcmanageddisklabeus01"
  location             = var.location
  resource_group_name  = var.asp_rg
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 60
}

resource "azurerm_virtual_machine_data_disk_attachment" "example" {
  managed_disk_id    = azurerm_managed_disk.fc_mgdisk.id
  virtual_machine_id = azurerm_windows_virtual_machine.fc_vm.id
  lun                = "60"
  caching            = "ReadWrite"
}