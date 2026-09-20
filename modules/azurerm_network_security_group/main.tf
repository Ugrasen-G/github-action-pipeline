variable "security_group" {}

resource "azurerm_network_security_group" "security_group1" {
  for_each            = var.security_group
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}



