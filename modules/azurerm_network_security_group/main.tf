variable "security_group" {}
# variable "nic_name" {}

resource "azurerm_network_security_group" "security_group1" {
  for_each            = var.security_group
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}

data "azurerm_network_interface" "example1" {
  for_each = var.security_group
  name                = each.value.nic_name[0]
  resource_group_name = each.value.resource_group_name
}
data "azurerm_network_interface" "example2" {
  for_each = var.security_group
  name                = each.value.nic_name[1]
  resource_group_name = each.value.resource_group_name
}

# data "azurerm_network_security_group" "example3" {
#   for_each = var.security_group
#   name                = each.value.name
#   resource_group_name = each.value.resource_group_name
# }

resource "azurerm_network_interface_security_group_association" "primary" {
  depends_on = [ azurerm_network_security_group.security_group1 ]
  for_each = var.security_group
  network_interface_id      = data.azurerm_network_interface.example1[each.key].id
  network_security_group_id = azurerm_network_security_group.security_group1[each.key].id
}

resource "azurerm_network_interface_security_group_association" "secondry" {
  depends_on = [ azurerm_network_security_group.security_group1 ]
  for_each = var.security_group
  network_interface_id    =  data.azurerm_network_interface.example2[each.key].id
  network_security_group_id = azurerm_network_security_group.security_group1[each.key].id
}