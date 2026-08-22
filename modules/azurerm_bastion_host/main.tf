variable "bastion_host" {}
 
data "azurerm_subnet" "bastion_subnet" {
     for_each = var.bastion_host
     name = "AzureBastionSubnet"
  virtual_network_name = each.value.virtual_network_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_bastion_host" "bastion" {
  for_each            = var.bastion_host
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = "bastion"
    subnet_id            = data.azurerm_subnet.bastion_subnet[each.key].id
    public_ip_address_id = data.azurerm_public_ip.bastionpublicip[each.key].id
  }
}

data "azurerm_public_ip" "bastionpublicip" {
  for_each = var.bastion_host
  name                 = "Bastionpublicip1"
  resource_group_name  = each.value.resource_group_name
}

