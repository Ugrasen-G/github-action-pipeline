variable "keyvault" {}
variable "vm_username" {
  description = "vm username"
  type        = string
  sensitive   = true
}

variable "vm_password" {
  description = "vm password"
  type        = string
  sensitive   = true
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault1" {
  for_each                    = var.keyvault
  name                        = each.value.name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  rbac_authorization_enabled  = false
  enabled_for_disk_encryption = true
  tenant_id                   =  data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name = each.value.sku_name

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

key_permissions = [ "Get", ]
secret_permissions = ["Get", "List", "Set", "Delete", "Recover", "Purge"]
 storage_permissions =[ "Get", ]
  }
}

resource "azurerm_key_vault_secret" "username" {
  for_each = var.keyvault
   name         = each.value.key_username
   value        = var.vm_username
   key_vault_id = azurerm_key_vault.keyvault1[each.key].id
 }

 resource "azurerm_key_vault_secret" "password" {
  for_each = var.keyvault
   name         = each.value.key_password
   value        = var.vm_password
   key_vault_id = azurerm_key_vault.keyvault1[each.key].id
 }