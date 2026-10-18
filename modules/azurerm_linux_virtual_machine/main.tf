variable "linuxvm" {}

data "azurerm_key_vault" "keyvault1" {
  for_each = var.linuxvm
  name = each.value.vault_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault_secret" "username" {
  for_each = var.linuxvm
  name         = each.value.key_username
  key_vault_id = data.azurerm_key_vault.keyvault1[each.key].id
}

data "azurerm_key_vault_secret" "password" {
  for_each = var.linuxvm
  name         = each.value.key_password
  key_vault_id = data.azurerm_key_vault.keyvault1[each.key].id
}

data "azurerm_network_interface" "nic" {
  for_each = var.linuxvm
  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name
}

 resource "azurerm_linux_virtual_machine" "firstvm" {
  for_each              = var.linuxvm
  name                  = each.value.name
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  network_interface_ids = [data.azurerm_network_interface.nic[each.key].id]
  size                  = each.value.size
  admin_username = data.azurerm_key_vault_secret.username[each.key].value
  admin_password = data.azurerm_key_vault_secret.password[each.key].value
  disable_password_authentication = false
  
os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
