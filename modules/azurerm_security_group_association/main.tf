variable "security_group_association" {}

data "azurerm_subnet" "frontend1_subnet" {
  for_each             = var.security_group_association
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_network_security_group" "security_group1" {
  for_each            = var.security_group_association
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "subnet_to_nsg" {
  for_each = var.security_group_association
  subnet_id      = data.azurerm_subnet.frontend1_subnet[each.key].id
  network_security_group_id = data.azurerm_network_security_group.security_group1[each.key].id
}


