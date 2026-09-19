module "azurerm_resource_group" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}

# module "azurerm_storage_account" {
#   depends_on = [module.azurerm_resource_group]
#   source     = "../../modules/azurerm_storage_account"
#   stg        = var.stg
# }

module "azurerm_virtual_network" {
  depends_on = [module.azurerm_resource_group]
  source     = "../../modules/azurerm_virtual_network"
  vnet       = var.vnet
}

module "azurerm_subnet" {
  depends_on = [module.azurerm_virtual_network]
  source     = "../../modules/azurerm_subnet"
  subnet     = var.subnet
}

module "azurerm_network_security_group" {
  depends_on     = [module.azurerm_virtual_network]
  source         = "../../modules/azurerm_network_security_group"
  security_group = var.security_group
}

module "azurerm_network_security_rules" {
  depends_on     = [module.azurerm_network_security_group]
  source         = "../../modules/azurerm_network_security_rule"
  security_rules = var.security_rules
}

module "azurerm_key_vault" {
  depends_on = [module.azurerm_resource_group]
  source     = "../../modules/azurerm_key_vault"
  keyvault   = var.keyvault
}

module "azurerm_nat_gateway" {
  depends_on = [module.azurerm_subnet]
  source     = "../../modules/azurerm_NAT_gateway"
  natgw      = var.natgw
}

# module "azurerm_bastion_host" {
#   depends_on   = [module.azurerm_public_ip, module.azurerm_subnet]
#   source       = "../../modules/azurerm_bastion_host"
#   bastion_host = var.bastion_host
# }

module "azurerm_public_ip" {
  depends_on      = [module.azurerm_subnet]
  source          = "../../modules/azurerm_public_ip"
  bastionpublicip = var.bastionpublicip
}

module "azurerm_linux_virtual_machine" {
  depends_on  = [module.azurerm_key_vault, module.azurerm_public_ip]
  source      = "../../modules/azurerm_linux_virtual_machine"
  linuxvm     = var.linuxvm
  vm_password = var.vm_password
}

# module "azurerm_application_gateway" {
#   depends_on = [module.azurerm_linux_virtual_machine]
#   source     = "../../modules/azurerm_application_gateway"
#   appgw      = var.appgw
# }