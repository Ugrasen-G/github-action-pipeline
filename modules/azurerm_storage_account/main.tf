variable "stg" {}

resource "azurerm_storage_account" "storage" {
  for_each                 = var.stg
  name                     = each.value.name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}


data "azurerm_storage_account" "storagecontainer" {
  for_each = var.stg
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_storage_container" "container" {
  for_each = var.stg
  name                  = each.value.container_name
  storage_account_id    = azurerm_storage_account.storagecontainer[each.key].id
  container_access_type = each.value.container_access_type
}


