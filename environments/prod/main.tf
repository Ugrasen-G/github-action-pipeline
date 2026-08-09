module "resource_group" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}

module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_virtual_network"
  vnet       = var.vnet
}
module "azurerm_subnet" {
  depends_on = [module.virtual_network]
  source     = "../../modules/azurerm_subnet"
  subnet     = var.subnet
}

module "azurerm_network_security_group" {
  depends_on     = [module.azurerm_subnet]
  source         = "../../modules/network_security_group"
  security_group = var.security_group
}

module "azurerm_linux_virtual_machine" {
  depends_on = [module.azurerm_subnet]
  source     = "../../modules/azurerm_linux_virtual_machine"
  linuxvm    = var.linuxvm
}