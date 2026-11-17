variable "postgresql" {}
# resource "azurerm_subnet" "example" {
#   name                 = "example-sn"
#   resource_group_name  = azurerm_resource_group.example.name
#   virtual_network_name = azurerm_virtual_network.example.name
#   address_prefixes     = ["10.0.2.0/24"]
#   service_endpoint {
#     service = "Microsoft.Storage"
#   }
#   delegation {
#     name = "fs"
#     service_delegation {
#       name = "Microsoft.DBforPostgreSQL/flexibleServers"
#       actions = [
#         "Microsoft.Network/virtualNetworks/subnets/join/action",
#       ]
#     }
#   }
# }
# resource "azurerm_private_dns_zone" "example" {
#   name                = "example.postgres.database.azure.com"
#   resource_group_name = azurerm_resource_group.example.name
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "example" {
#   name                = "exampleVnetZone.com"
#   private_dns_zone_id = azurerm_private_dns_zone.example.id
#   virtual_network_id  = azurerm_virtual_network.example.id
#   depends_on          = [azurerm_subnet.example]
# }

data "azurerm_private_dns_zone" "zone" {
  for_each = var.postgresql
  name                = each.value.dns_zone_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_subnet" "Database-subnet" {
     for_each = var.postgresql
     name =each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_postgresql_flexible_server" "database" {
    for_each = var.postgresql
  name                          = each.value.name
  resource_group_name           = each.value.resource_group_name
  location                      = each.value.location
  version                       = each.value.version
  delegated_subnet_id           = data.azurerm_subnet.Database_subnet[each.key].id
  private_dns_zone_id           = data.azurerm_private_dns_zone.zone[each.key].id
  public_network_access_enabled = each.value.public_network_access_enabled
  administrator_login           = each.value.administrator_login
  administrator_password        = each.value.administrator_password
  zone                          = each.value.zone
  storage_mb   = each.value.storage_mb
  storage_tier = each.value.storage_tier
  sku_name   = each.value.sku_name
}