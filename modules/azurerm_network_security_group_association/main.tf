# data "azurerm_subnet" "frontend1_subnet" {
#   for_each             = var.security_group
#   name                 = "frontend-subnet"
#   virtual_network_name = each.value.virtual_network_name
#   resource_group_name  = each.value.resource_group_name
# }

# data "azurerm_network_security_group" "security_group1" {
#   for_each            = var.security_group
#   name                = "NSG1"
#   resource_group_name = each.value.resource_group_name
# }

# resource "azurerm_network_interface_security_group_association" "subnet_to_nsg" {
#   network_interface_id      = data.azurerm_subnet.frontend1_subnet["frontend-subnet"].id
#   network_security_group_id = data.azurerm_network_security_group.security_group1["NSG1"].id
# }
