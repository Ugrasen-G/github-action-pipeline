variable "natgw" {}

resource "azurerm_nat_gateway" "natgw" {
    for_each = var.natgw
  name                    = each.value.name
  location                = each.value.location
  resource_group_name     = each.value.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}