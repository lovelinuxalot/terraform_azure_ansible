resource "azurerm_virtual_machine" "vm" {
  count    = var.vm_count
  name     = "node0${count.index + 1}"
  location = azurerm_resource_group.rg.location
  # zones = [[count.index+1]]
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.NIC[count.index].id]
  vm_size               = var.vm_size

  storage_image_reference {
    publisher = "${var.storage_image_reference[0]}"
    offer     = "${var.storage_image_reference[1]}"
    sku       = "${var.storage_image_reference[2]}"
    version   = "${var.storage_image_reference[3]}"
  }

  storage_os_disk {
    name              = "node0${count.index + 1}-Data-Disk"
    managed_disk_type = "${var.storage_os_disk[0]}"
    create_option     = "${var.storage_os_disk[1]}"
    caching           = "${var.storage_os_disk[2]}"

  }

  os_profile {
    computer_name  = "node0${count.index + 1}"
    admin_username = var.admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("${var.local_public_ssh_key}")
      path     = "${var.public_ssh_key_path}"
    }
  }

}

