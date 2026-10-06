variable "linuxvm" {}
variable "vm_password" {
  description = "vm password"
  type        = string
  sensitive   = true
}


# data "azurerm_public_ip" "vmpublicip" {
#     for_each = var.linuxvm
#     name = each.value.publicip_name
#   resource_group_name = each.value.resource_group_name
# }

data "azurerm_subnet" "frontend_subnet" {
     for_each = var.linuxvm
     name = "frontend-subnet"
  virtual_network_name = each.value.virtual_network_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault" "keyvault1" {
  for_each = var.linuxvm
  name = each.value.vault_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_key_vault_secret" "vm_password" {
  for_each = var.linuxvm
   name         = each.value.key_name
   value        = var.vm_password
   key_vault_id = data.azurerm_key_vault.keyvault1[each.key].id
 }

 resource "azurerm_network_interface" "nic" {
  for_each            = var.linuxvm
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "nic_frontend_vm"
    subnet_id                     = data.azurerm_subnet.frontend_subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    # public_ip_address_id  = data.azurerm_public_ip.vmpublicip[each.key].id
  }
}

 resource "azurerm_linux_virtual_machine" "firstvm" {
  for_each              = var.linuxvm
  name                  = each.value.name
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]
  size                  = each.value.size
  
admin_username                  = each.value.admin_username
# admin_password                  = each.value.admin_password
 admin_password = azurerm_key_vault_secret.vm_password[each.key].value
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
