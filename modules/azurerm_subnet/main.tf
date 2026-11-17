variable "subnet" {}

resource "azurerm_subnet" "subnetA" {
  for_each             = var.subnet
  name                 = each.value.name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
  address_prefixes     = each.value.address_prefixes

 dynamic "delegation" {
    for_each = each.value.name == "Database-subnet" ? [1] : []

    content {
      name = "postgresql-delegation"

      service_delegation {
        name = "Microsoft.DBforPostgreSQL/flexibleServers"

        actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action"
        ]
      }
    }
  }
}